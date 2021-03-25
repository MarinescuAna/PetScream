using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using PetScreamAspNET.BusinessLogicLayer.Services.Interface;
using PetScreamAspNET.Common.Utils;
using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using PetScreamAspNET.DataAccessLayer.Domain.Model;
using System;
using System.Threading.Tasks;

namespace PetScreamAspNET.Controllers
{
    [Route("api/[controller]")]
    [Authorize]
    [ApiController]
    public class AdController : BaseController
    {
        private readonly IAdService _adService;
        public AdController(IAdService adService, IConfiguration configuration, IHttpContextAccessor httpContextAccessor)
            :base(configuration,httpContextAccessor)
        {
            _adService = adService;
        }


        [HttpPost]
        [Route("/api/Ad/InsertAd")]
        public async Task<IActionResult> InsertAd(InsertPostSender insertPostSender)
        {
            if (insertPostSender == null)
            {
                return StatusCode(Codes.Number_204, Messages.NoContent_204NoContent);
            }

            var imageId = Guid.NewGuid();
            Post post = new Post {
                PostID = Guid.NewGuid(),
                ImageId = imageId,
                LostDatetime = DateTime.Parse(insertPostSender.LostDatetime),
                Status = Status.Lost,
                LostPlaceAddress = insertPostSender.LostPlaceAddress,
                UserId = ExtractEmailFromJWT(),
                OwnerAddress = insertPostSender.OwnerAddress,
                PetDescription = insertPostSender.PetDescription,
                PostDatetime = DateTime.Now,
                Title=insertPostSender.Title,
                Image=new Image { 
                    ImageID=imageId,
                    Content=insertPostSender.BinaryContentImage,
                    Extention=insertPostSender.ExtentionImage,
                    Filename=insertPostSender.ImageName
                }
            };

            if (await _adService.InsertAdAsync(post) == true)
            {
                return StatusCode(Codes.Number_200,Messages.Success_200Ok);
            }

            return StatusCode(Codes.Number_400, Messages.SthWentWrong_400BadRequest);
        }
    }
}
