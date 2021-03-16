using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace PetScreamAspNET.BusinessLogicLayer.Services.Interface
{
    public interface IUserService
    {
        Task<User> GetUserByEmailAsync(string email);
        Task<bool> UpdateUserInformationAsync(User user);
        Task<bool> InsertUserAsync(User user);
    }
}
