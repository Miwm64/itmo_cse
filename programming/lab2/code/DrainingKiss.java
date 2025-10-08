import ru.ifmo.se.pokemon.SpecialMove;
import ru.ifmo.se.pokemon.Type;
import ru.ifmo.se.pokemon.Stat;
import ru.ifmo.se.pokemon.Pokemon;
import java.lang.Math;

public class DrainingKiss extends SpecialMove{
	private int damage_dealt = 0;
	public DrainingKiss(){
		accuracy = 100;
		power = 50;
		type = Type.FAIRY;
	}

	@Override	
	protected String describe(){
		return "uses DrainingKiss";
	}
	
	@Override
	protected void applyOppDamage(Pokemon def, double damage){
		def.setMod(Stat.HP, (int) Math.round(damage));
		damage_dealt = (int) Math.round(damage);
	}

	@Override
	protected void applySelfDamage(Pokemon att, double damage){
		att.setMod(Stat.HP, -Math.abs((int) Math.round(damage_dealt*0.75)));
		damage_dealt = 0;
	}
}
