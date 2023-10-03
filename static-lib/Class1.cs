using System.Runtime.InteropServices;

namespace static_lib;

public class Class1
{
    [UnmanagedCallersOnly(EntryPoint = "multiply")]
    public static int Multiply(int a, int b)
    {
        return a * b;
    }
}
