using PetScreamAspNET.BusinessLogicLayer.Repository.Impl;
using PetScreamAspNET.BusinessLogicLayer.Repository.Interface;
using PetScreamAspNET.Common.Log;
using PetScreamAspNET.DataAccessLayer.Repository;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace PetScreamAspNET.BusinessLogicLayer.Repository.UnitOfWork
{
    public class UnitOfWork:IUnitOfWork
    {

        protected readonly PetScreamDbContext context;
        private IUserRepo userRepository;
        private IAdRepo adRepository;
        private readonly ILoggerService _loggerService;
        public UnitOfWork(PetScreamDbContext ctx, ILoggerService loggerService)
        {
            context = ctx;
            _loggerService = loggerService;
        }
        public IAdRepo AdRepository
        {
            get
            {
                if (adRepository == null)
                {
                    adRepository = new AdRepo(context, _loggerService);
                }

                return adRepository;
            }
        }
        public IUserRepo UserRepository
        {
            get
            {
                if (userRepository == null)
                {
                    userRepository = new UserRepo(context, _loggerService);
                }

                return userRepository;
            }
        }
        public async Task<bool> CommitAsync(string loggDetails)
        {
            try
            {
                return await context.SaveChangesAsync() > 0;
            }
            catch (Exception ex)
            {
                _loggerService.LogError(loggDetails, ex.Message);
                if (!string.IsNullOrEmpty(ex.InnerException.Message))
                {
                    _loggerService.LogError(loggDetails, ex.InnerException.Message);
                }
                Dispose();
            }

            return false;
        }

        public async void Dispose()
        {
            context.Dispose();
        }
    }
}
