using Microsoft.AspNetCore.Mvc;

namespace Web.Controllers;

public class HomeController(IConfiguration configuration, IHttpClientFactory httpClientFactory) : Controller
{
    public async Task<IActionResult> Index()
    {
        var apiUrl = configuration["ApiUrl"];
        var apiPath = $"{apiUrl}/hello";

        var client = httpClientFactory.CreateClient();
        var response = await client.GetStringAsync(apiPath);

        ViewBag.ApiPath = apiPath;
        ViewBag.Response = response;

        return View();
    }
}
