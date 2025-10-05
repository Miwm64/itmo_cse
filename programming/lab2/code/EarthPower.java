import ru.ifmo.se.pokemon.SpecialMove;
import ru.ifmo.se.pokemon.Type;


public class EarthPower extends SpecialMove{
	public EarthPower(){
		accuracy = 100;
		power = 90;
		type = Type.GROUND;
	}

	protected java.lang.String describe(){
		return "EarthPower";
	}	
}
