package shopping;

import java.util.Vector;

public class Database {
	private Object[][] goods=new Object[][]{{1,"������",500000},{2,"����",1000000},{3,"����",2000000},{4,"������",3000000},{5,"������",4000000}};
	public Vector<Vector<Object>> getDB(){
		Vector<Vector<Object>> v = new Vector<Vector<Object>>();
		for(int i = 0 ; i < goods.length;i++){
			Vector<Object> vo = new Vector<Object>();
			for(int j = 0; j < goods[i].length;j++ ){
				vo.add((Object)goods[i][j]);
			}
			v.add(vo);
		}
		return v;
	}
}
