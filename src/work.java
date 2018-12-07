
public class Foo implements Comparable<Foo> {
    public final int i;
	public Foo(int value) { 
        i = value; 
    }

	public int compareTo(Foo f) { 
		return i - f.i; 
	}

	public String toString() {
		return "Foo(" + i + ")";
	}
}

List<Foo> foos = new ArrayList<Foo>()
foos.add(new Foo(12))
foos.add(new Foo(3))
foos.add(new Foo(8))

foos // [Foo(12), Foo(3), Foo(8)]

Collections.sort(foos)

foos // [Foo(3), Foo(8), Foo(12)]
