String fakeConsole = "";
String fakeConsole2 = "";
String fakeConsole3 = "";
String fakeConsole4 = "";
String fakeConsole5 = "";


void Println(String in) {
  println(in);
  fakeConsole = fakeConsole + "\n" + in;
}

void Println2(String in) {
  println(in);
  fakeConsole2 = fakeConsole2 + in;
}

void Println3(int in) {
  println(in);
  fakeConsole3 = fakeConsole3 + "\n" + in;
}

void Println4(String in) {
  println(in);
  fakeConsole4 = fakeConsole4 + in;
}

void Println5(String in) {
  println(in);
  fakeConsole5 = fakeConsole5 + in;
}

void PrintArray(int[] f) {
  printArray(f);
  fakeConsole = fakeConsole + "\n" + f;
}
