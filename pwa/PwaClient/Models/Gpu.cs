public class Gpu
{
    public string Name { get; set; }
    public int VideoRamCapacity { get; set; }

    // Konstruktor
    public Gpu(string name, int videoRamCapacity)
    {
        this.Name = name;
        this.VideoRamCapacity = videoRamCapacity;
    }
}