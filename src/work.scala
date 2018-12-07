

case class Foo(i: Int)


object Typeclasses {

  val list = List(4, 7, 2).sorted // Works! What sourcery is this

  val list2 = List(Foo(2), Foo(5), Foo(3)) // Compile error! Why

}

