using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using PetScreamAspNET.BusinessLogicLayer.Services.Interface;
using PetScreamAspNET.Common.Utils;
using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using PetScreamAspNET.DataAccessLayer.Domain.Model;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace PetScreamAspNET.Controllers
{
    [Route("api/[controller]")]
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
        // [Authorize]
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
                LostDatetime = insertPostSender.LostDatetime=="null"? DateTime.Now: DateTime.Parse(insertPostSender.LostDatetime),
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

        [HttpGet]
        [Route("/api/Ad/GetAds")]
        public async Task<IActionResult> GetAds()
        {
            var ads = (List<Post>)await _adService.GetAllAdsAsync();
            var adsSent = new List<AdSent>();

            foreach(var ad in ads)
            {
                adsSent.Add(new AdSent
                {
                    ContentImage=ad.Image?.Content,
                    FoundDatetime=ad.FoundDatetime,
                    FounderAddress=ad.FounderAddress,
                    FounderName=ad.FounderName,
                    FounderPhone=ad.FounderPhone,
                    LostDatetime=ad.LostDatetime,
                    LostPlaceAddress=ad.LostPlaceAddress,
                    Name=ad.Owner?.Name,
                    Title=ad.Title,
                    OwnerAddress=ad.OwnerAddress,
                    PetDescription=ad.PetDescription,
                    Phone=ad.Owner?.Phone,
                    PostDatetime=ad.PostDatetime,
                    UserEmail=ad.UserId,
                    PostID=ad.PostID.ToString(),
                    Status=ad.Status.ToString()
                });
            }
           
                return StatusCode(Codes.Number_200, adsSent);
        }
    }
}
