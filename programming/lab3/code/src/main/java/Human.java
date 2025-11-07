package main.java;

public class Human {
    String _name;
    public Human(String name) {
        _name = name;
    }

    public String shout(){
        return "I am " + _name.toUpperCase() + "!!!";
    }
}