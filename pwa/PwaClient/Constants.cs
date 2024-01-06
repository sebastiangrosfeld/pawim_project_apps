public static class Constants
{
    // public const string ApiUrl = "http://localhost:8080";
    public const string ApiUrl = "https://pawimapi.azurewebsites.net";
    public const string ComputersUrl = ApiUrl + "/apiServer/computers";
    
    public const string RamsUrl = ApiUrl + "/apiServer/rams";

    public const string GpusUrl = ApiUrl + "/apiServer/gpus";

    public const string LoginUrl = ApiUrl + "/apiServer/authorization/login";

    public const string RegisterUrl = ApiUrl + "/apiServer/authorization/register";

    public const string ChangePasswordrUrl = ApiUrl + "/apiServer/authorization/change-password";
}