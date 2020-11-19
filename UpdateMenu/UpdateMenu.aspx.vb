Imports System.IO
Imports System.Net
Imports System.Text.RegularExpressions

Partial Class WebPages_EntaWebCustom_UpdateMenu
    Inherits System.Web.UI.Page

    Public SourceWebsite As String = "https://hayestheatre.com.au"
    'Basic Auth Settings:
    Public Username As String = ""
    Public Password As String = ""

    'head settings:
    Public ScrapeHeadContent As Boolean = true
    Public SourceHead As String = "/our-story/"
    Public HeadStartTag As String = "<link rel='stylesheet'"
    Public HeadEndTag As String = "<script type='text/javascript' src='https://hayestheatre.com.au"
    Public FixIDsInHeaders As Boolean = true
    Public IncludeHeadEndTagInOutput As Boolean = false

    'header settings:
    Public ScrapeHeaderContent As Boolean = true
    Public SourceHeader As String = "/our-story/"
    Public HeaderStartTag As String = "<h1 class=""site-title sr-only"""
    Public HeaderEndTag As String = "<div class=""page"">"
    Public IncludeHeaderEndTagInOutput As Boolean = false

    'footer settings:
    Public ScrapeFooterContent As Boolean = true
    Public SourceFooter As String = "/our-story/"
    Public FooterStartTag As String = "<!-- start partials/subscribe-footer.php -->"
    Public FooterEndTag As String = "<!-- /.internal-page -->"
    Public IncludeFooterEndTagInOutput As Boolean = true

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        lblWebsite.Text = SourceWebsite

        if ScrapeHeadContent = true Then        
            lblHead.Text = "Head: " + SourceWebsite + SourceHead
            Dim headTemplateContent As String = CleanHTML(StripToTags(GetHtmlPage(SourceWebsite & SourceHead), HeadStartTag, HeadEndTag, IncludeHeadEndTagInOutput))
            If FixIDsInHeaders = true Then
                Dim rx As New Regex("^\<link rel='stylesheet' (id='.*?')", RegexOptions.Multiline)
                headTemplateContent = rx.Replace(headTemplateContent, "<link rel='stylesheet'")
            End if
            headTemplate.Text = headTemplateContent
        End If
        if ScrapeHeaderContent = true Then
            lblHeader.Text = "Header: " + SourceWebsite + SourceHeader
            headerTemplate.Text = CleanHTML(StripToTags(GetHtmlPage(SourceWebsite & SourceHeader), HeaderStartTag, HeaderEndTag, IncludeHeaderEndTagInOutput))
        End If
        if ScrapeFooterContent = true Then
            lblFooter.Text = "Footer: " + SourceWebsite + SourceFooter
            footerTemplate.Text = CleanHTML(StripToTags(GetHtmlPage(SourceWebsite & SourceFooter), FooterStartTag, FooterEndTag, IncludeFooterEndTagInOutput))
        End If
    End Sub


    Public Function GetHtmlPage(strURL As String) As [String]
        ' the html retrieved from the page
        Dim strResult As [String]
        System.Net.ServicePointManager.SecurityProtocol = ServicePointManager.SecurityProtocol Or SecurityProtocolType.Tls11 Or SecurityProtocolType.Tls12
        Dim objResponse As System.Net.WebResponse
        Dim objRequest As System.Net.WebRequest = System.Net.HttpWebRequest.Create(strURL)

        'Add Basic Auth Credentials if required
        If Username <> "" And Password <> "" Then
            Dim encodedCredentials As String = System.Convert.ToBase64String(System.Text.Encoding.GetEncoding("ISO-8859-1").GetBytes(Username & ":" + Password))
            objRequest.Headers.Add("Authorization", "Basic " & encodedCredentials)
        End If

        objResponse = objRequest.GetResponse()
        ' the using keyword will automatically dispose the object 
        ' once complete
        Using sr As New System.IO.StreamReader(objResponse.GetResponseStream())
            strResult = sr.ReadToEnd()
            ' Close and clean up the StreamReader
            sr.Close()
        End Using
        Return strResult
    End Function

    Public Function StripToTags(HTML As String, startTag As String, endTag As String, includeEndTagInOutput As Boolean) As String
        Dim startTagPosition As Integer = 0
        Dim endTagPosition As Integer = HTML.Length
        Dim StrippedContent As String = ""
        if startTag.Length > 0 then
            startTagPosition = InStr(HTML, startTag) -1
        end if
        if endTag.Length > 0 then
            endTagPosition = InStr(HTML, endTag) -1
        end if
        if startTagPosition < 0 Then
            return "WARNING: START TAG NOT FOUND.  PLEASE CHECK SOURCE AND CONFIG.  Failed to find tag """ & System.Web.HttpUtility.HtmlEncode(startTag) & """" 
        end if
        if endTagPosition < 1 Then
            return "WARNING: END TAG NOT FOUND.  PLEASE CHECK SOURCE AND CONFIG.  Failed to find tag """ & System.Web.HttpUtility.HtmlEncode(endTag) & """"
        end if
        If endTagPosition < startTagPosition Then
            return "WARNING: END TAG FOUND BEFORE START TAG.  CHECK SOURCE AND CONFIG"
        End If
        Try
            If includeEndTagInOutput Then
                return HTML.Substring(startTagPosition, (endTagPosition - startTagPosition) + endTag.Length)
            Else
                return HTML.Substring(startTagPosition, (endTagPosition - startTagPosition))
            End If
        Catch ex As Exception
            return "Debug Info:<br>Start Tag: " & startTag & " Position:" & startTagPosition & "<br>End Tag: " & endTag & "Position:" & endTagPosition
        End Try
        
    End Function

     Public Function CleanHTML(contentToClean) As String
        Dim rx As New Regex("(href=/"")(?<!/)/(?!/)(?=\S)")

        Dim CleanedContent As String = rx.Replace(contentToClean, "href=""" & SourceWebsite & "/")
        CleanedContent = CleanedContent.Replace("='/", "='" & SourceWebsite & "/")
        CleanedContent = CleanedContent.Replace("=""/", "=""" & SourceWebsite & "/")
        CleanedContent = CleanedContent.Replace(", /", ", " & SourceWebsite & "/")
        Return CleanedContent
    End Function  



    Protected Sub btnUpdateContent_Click(sender As Object, e As EventArgs) Handles btnUpdateContent.Click

        if ScrapeHeadContent = true Then
            Dim headTemplateContent As String = CleanHTML(StripToTags(GetHtmlPage(SourceWebsite & SourceHead), HeadStartTag, HeadEndTag, IncludeHeadEndTagInOutput))
            If FixIDsInHeaders = true Then
                Dim rx As New Regex("^\<link rel='stylesheet' (id='.*?')", RegexOptions.Multiline)
                headTemplateContent = rx.Replace(headTemplateContent, "<link rel='stylesheet'")
            End if
            My.Computer.FileSystem.WriteAllText(HttpContext.Current.Server.MapPath("~") & "\ClientFiles\Head.html", headTemplateContent, False)
        End If
        if ScrapeHeaderContent = true Then
            My.Computer.FileSystem.WriteAllText(HttpContext.Current.Server.MapPath("~") & "\ClientFiles\Header.html", CleanHTML(StripToTags(GetHtmlPage(SourceWebsite & SourceHeader), HeaderStartTag, HeaderEndTag, IncludeHeaderEndTagInOutput)), False)
        End If
        if ScrapeFooterContent = true Then
            My.Computer.FileSystem.WriteAllText(HttpContext.Current.Server.MapPath("~") & "\ClientFiles\Footer.html", CleanHTML(StripToTags(GetHtmlPage(SourceWebsite & SourceFooter), FooterStartTag, FooterEndTag, IncludeFooterEndTagInOutput)), False)
        End If
        
        Response.Redirect("~/")
    End Sub
End Class
