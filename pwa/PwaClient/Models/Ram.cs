public class Ram
{
    public string Name { get; set; }
    public int RamCapacity { get; set; }
    public int MemoryRate { get; set; }

    // Konstruktor
    public Ram(string name, int ramCapacity, int memoryRate)
    {
        this.Name = name;
        this.RamCapacity = ramCapacity;
        this.MemoryRate = memoryRate;
    }
}