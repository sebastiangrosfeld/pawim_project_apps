public class Computer
{
    public string Name { get; set; }
    public string Type { get; set; }
    public string EnclosureName { get; set; }
    public string CpuName { get; set; }
    public Ram Ram { get; set; }
    public int HardDiskCapacity { get; set; }
    public Gpu Gpu { get; set; }
    public int PowerSupply { get; set; }
    public int Price { get; set; }

    // Konstruktor
    public Computer(string name, string type, string enclosureName, string cpuName, Ram ram,
                    int hardDiskCapacity, Gpu gpu, int powerSupply, int price)
    {
        this.Name = name;
        this.Type = type;
        this.EnclosureName = enclosureName;
        this.CpuName = cpuName;
        this.Ram = ram;
        this.HardDiskCapacity = hardDiskCapacity;
        this.Gpu = gpu;
        this.PowerSupply = powerSupply;
        this.Price = price;
    }
}