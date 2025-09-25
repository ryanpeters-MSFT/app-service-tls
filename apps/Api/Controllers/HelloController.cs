using Microsoft.AspNetCore.Mvc;

namespace Api.Controllers;

[ApiController]
[Route("[controller]")]
public class HelloController : ControllerBase
{
    public string Get() => "Hello from the API";
}
