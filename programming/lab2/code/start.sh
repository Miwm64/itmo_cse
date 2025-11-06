#!/bin/bash
javac -cp .:.compiled/Pokemon.jar Main.java
mv *.class .compiled
cd .compiled
java -cp .:Pokemon.jar Main

