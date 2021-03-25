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
    }
}
