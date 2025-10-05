import ru.ifmo.se.pokemon.Pokemon;


public class Landorus extends Pokemon{
	public Landorus(){
		setStats(89, 125, 90, 115, 80, 101);
		//EarthPower e = new EarthPower();
		addMove(new EarthPower());
	}
}
