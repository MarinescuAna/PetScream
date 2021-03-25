using PetScreamAspNET.BusinessLogicLayer.Repository.Interface;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace PetScreamAspNET.BusinessLogicLayer.Repository.UnitOfWork
{
    public interface IUnitOfWork: IDisposable
    {
        Task<bool> CommitAsync(string loggDetails);
        IUserRepo UserRepository { get; }
        IAdRepo AdRepository { get; }

    }
}
