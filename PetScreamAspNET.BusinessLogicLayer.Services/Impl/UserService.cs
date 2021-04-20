using PetScreamAspNET.BusinessLogicLayer.Repository.UnitOfWork;
using PetScreamAspNET.BusinessLogicLayer.Services.Interface;
using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using System;
using System.Threading.Tasks;

namespace PetScreamAspNET.BusinessLogicLayer.Services.Impl
{
    public class UserService:IUserService
    {

        protected readonly IUnitOfWork _unitOfWork;
        public UserService(IUnitOfWork unitOfWork) => _unitOfWork = unitOfWork;
        public async Task<User> GetUserByEmailAsync(string email) => await _unitOfWork.UserRepository.GetItemAsync(u => u.Email == email);

        public async Task<bool> InsertUserAsync(User user)
        {
            _unitOfWork.UserRepository.InsertItemAsync(user);

            return await _unitOfWork.CommitAsync("Insert an user, and Commit");
        }

        public async Task<bool> UpdateUserInformationAsync(User user)
        {
            var user2 = await GetUserByEmailAsync(user.Email);

            if (!String.IsNullOrEmpty(user.AccessToken))
            {
                user2.AccessToken = user.AccessToken;
            }

            if (user.AccessTokenExp != null)
            {
                user2.AccessTokenExp = user.AccessTokenExp;
            }

            await _unitOfWork.UserRepository.UpdateItemAsync(u => u.Email == user.Email, user2);

            return await _unitOfWork.CommitAsync("Try to update user information and commit");
        }
    }
}
