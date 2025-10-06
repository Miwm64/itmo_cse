import ru.ifmo.se.pokemon.PhysicalMove;
import ru.ifmo.se.pokemon.Type;
import ru.ifmo.se.pokemon.Stat;
import ru.ifmo.se.pokemon.Pokemon;
import java.lang.Math;

public class DoubleEdge extends PhysicalMove{
	private int damage_dealt = 0;
	public DoubleEdge(){
		accuracy = 120;
		power = 100;
		type = Type.NORMAL;
	}
	
	protected String describe(){
		return "uses DoubleEdge";
	}

	protected void applyOppDamage(Pokemon def, double damage){
		def.setMod(Stat.HP, (int) Math.round(damage));
		damage_dealt = (int) Math.round(damage);
	}

	protected void applySelfDamage(Pokemon att, double damage){
		att.setMod(Stat.HP, Math.abs((int) Math.round(damage_dealt/3.0)));
		damage_dealt = 0;
	}
}
