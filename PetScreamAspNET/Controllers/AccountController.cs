using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using PetScreamAspNET.BusinessLogicLayer.Services.Interface;
using PetScreamAspNET.Common.Utils;
using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using PetScreamAspNET.DataAccessLayer.Domain.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PetScreamAspNET.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : BaseController
    {
        private readonly IUserService _userService;
        public AccountController(IConfiguration configuration, IHttpContextAccessor httpContextAccessor, IUserService user) : base(configuration, httpContextAccessor)
        {
            _userService = user;
        }
        [HttpPost]
        [Route("/api/Account/Login")]
        public async Task<IActionResult> Login(UserLoginModel credentials)
        {
            if (credentials == null || string.IsNullOrEmpty(credentials.Email))
            {
                return StatusCode(Codes.Number_204, Messages.NoContent_204NoContent);
            }

            User user = await _userService.GetUserByEmailAsync(credentials.Email);

            if (user == null)
            {
                return StatusCode(Codes.Number_404, Messages.NoContent_204NoContent);
            }
            if (user.Password != credentials.Password)
            {
                return StatusCode(Codes.Number_404, Messages.InvalidCredentials_404NotFound);
            }

            TokenResponse jWToken = new TokenResponse
            {
                AccessToken = user.AccessToken = GenerateAccessToken(
                    user.Email),
                AccessTokenExpiration = DateTime.Now.AddMinutes(Codes.Number_2).ToString()
            };

            user.AccessTokenExp = DateTime.Parse(jWToken.AccessTokenExpiration);
            HttpContext.Session.SetString("Token", user.AccessToken);

            if (await _userService.UpdateUserInformationAsync(user) == true)
            {
                return StatusCode(Codes.Number_201, jWToken);
            }

            return StatusCode(Codes.Number_400, Messages.SthWentWrong_400BadRequest);

        }

        [HttpPost]
        [Route("/api/Account/Register")]
        public async Task<IActionResult> Register(UserRegisterModel userCredentials)
        {
            if (userCredentials == null || String.IsNullOrEmpty(userCredentials.Email))
            {
                return StatusCode(Codes.Number_204, Messages.NoContent_204NoContent);
            }

            if (await _userService.GetUserByEmailAsync(userCredentials.Email) != null)
            {
                return StatusCode(Codes.Number_409, Messages.AlreadyExist_409Conflict);
            }

            User user = new User
            {
                Email = userCredentials.Email,
                Name = userCredentials.Name,
                Phone = userCredentials.Phone,
                Password = userCredentials.Password
            };

            TokenResponse jWToken = new TokenResponse();

            user.AccessToken = jWToken.AccessToken = GenerateAccessToken(
                user.Email);
            user.AccessTokenExp = DateTime.Now.AddHours(Codes.Number_2);
            jWToken.AccessTokenExpiration = DateTime.Now.AddHours(Codes.Number_2).ToString();
            HttpContext.Session.SetString("Token", user.AccessToken);

            if (await _userService.InsertUserAsync(user) == true)
            {
                return StatusCode(Codes.Number_201, jWToken);
            }

            return StatusCode(Codes.Number_400, Messages.SthWentWrong_400BadRequest);
        }

        
    }
}
