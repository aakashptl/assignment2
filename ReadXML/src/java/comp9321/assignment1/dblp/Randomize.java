package comp9321.assignment1.dblp;

import java.util.Random;

public class Randomize {

	Random randnum;

    public Randomize() {
        randnum = new Random();

    }

    public boolean random(){
        return randnum.nextBoolean();
    }
}
