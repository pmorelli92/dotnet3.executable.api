using Microsoft.AspNetCore.Mvc;

namespace DotNet3.Executable.Api.Controllers
{
    public class EchoController : Controller
    {

        [HttpGet("api/echo/{message}")]
        public IActionResult Echo(string message)
        {
            return Json(new { Echoed = message });
        }
    }
}
