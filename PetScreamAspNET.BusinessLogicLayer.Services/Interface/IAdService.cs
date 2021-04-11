using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace PetScreamAspNET.BusinessLogicLayer.Services.Interface
{
    public interface IAdService
    {
        Task<bool> InsertAdAsync(Post post);
        Task<IEnumerable<Post>> GetAllAdsAsync();
    }
}
