using PetScreamAspNET.BusinessLogicLayer.Repository.UnitOfWork;
using PetScreamAspNET.BusinessLogicLayer.Services.Interface;
using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace PetScreamAspNET.BusinessLogicLayer.Services.Impl
{
    public class AdService: IAdService
    {
        protected readonly IUnitOfWork _unitOfWork;
        public AdService(IUnitOfWork unitOfWork) => _unitOfWork = unitOfWork;

        public async Task<bool> InsertAdAsync(Post post)
        {
            _unitOfWork.AdRepository.InsertItemAsync(post);

            return await _unitOfWork.CommitAsync("Insert a post into database");
        }

        public async Task<IEnumerable<Post>> GetAllAdsAsync() => await _unitOfWork.AdRepository.GetItemsAsync();

        public async Task<Post> GetAdByPostIdAsync(Guid postId) => await _unitOfWork.AdRepository.GetItemAsync(u => u.PostID == postId); 
        public async Task<bool> DeleteAdAsync(Post post)
        {
            await _unitOfWork.AdRepository.DeleteItemAsync(u => u.PostID == post.PostID, post);

            return await _unitOfWork.CommitAsync("Delete post");
        }

        public async Task<bool> UpdatePostByPostIdAsync(Post post)
        {
            await _unitOfWork.AdRepository.UpdateItemAsync(u => u.PostID == post.PostID, post);

            return await _unitOfWork.CommitAsync("Update post adding the founder");
        }
    }
}
