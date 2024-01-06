public class ComputerForm
{
    public string Name { get; set; } = "";
    public string Type { get; set; } = "";
    public string EnclosureName { get; set; } = "";
    public string CpuName { get; set; } = "";
    public string RamName { get; set; } = "";
    public int HardDiskCapacity { get; set; }
    public string GpuName { get; set; } = "";
    public int PowerSupply { get; set; }
    public int Price { get; set; }

    // Konstruktor
    // public ComputerForm(string name, string type, string enclosureName, string cpuName, string ram,
    //                 int hardDiskCapacity, string gpu, int powerSupply, int price)
    // {
    //     this.Name = name;
    //     this.Type = type;
    //     this.EnclosureName = enclosureName;
    //     this.CpuName = cpuName;
    //     this.RamName = ram;
    //     this.HardDiskCapacity = hardDiskCapacity;
    //     this.GpuName = gpu;
    //     this.PowerSupply = powerSupply;
    //     this.Price = price;
    // }
}