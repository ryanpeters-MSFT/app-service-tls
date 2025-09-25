using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using Web.Models;

namespace Web.Controllers;

public class HomeController(IConfiguration configuration, IHttpClientFactory httpClientFactory) : Controller
{
    public async Task<IActionResult> Index()
    {
        var apiUrl = configuration["ApiUrl"];
        var apiPath = $"{apiUrl}/hello";

        var client = httpClientFactory.CreateClient();
        var response = await client.GetStringAsync(apiPath);

        return View((object)response);
    }
}
