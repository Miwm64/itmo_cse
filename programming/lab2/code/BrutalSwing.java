import ru.ifmo.se.pokemon.PhysicalMove;
import ru.ifmo.se.pokemon.Type;


public class BrutalSwing extends PhysicalMove{
	public BrutalSwing(){
		accuracy = 100;
		power = 60;
		type = Type.DARK;
	}

	@Override
	protected String describe(){
		return "uses BrutalSwing";
	}
}
