package comp9321.assignment1.dblp;

import java.util.HashMap;

public class DocumentBean {

	HashMap<String, String> document;

	public DocumentBean(HashMap<String, String> doc) {
		document = doc;
		if (document.containsKey("Last Modified Date")) {
			String date = document.get("Last Modified Date");
			String date_value = date.substring(8, 10) + "-"
					+ date.substring(5, 7) + "-" + date.substring(0, 4);
			document.put("Last Modified Date", date_value);
		}

	}

	public String getKey() {
		return document.get("key");
	}

	public String getModifiedDate() {
		return document.get("Last Modified Date");
	}

	public String getYear() {
		return document.get("year");
	}

	public String getType() {
		return document.get("type");
	}

	public String getTitle() {
		return document.get("title");
	}

}
