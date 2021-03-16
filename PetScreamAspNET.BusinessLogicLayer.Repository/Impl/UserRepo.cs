using PetScreamAspNET.BusinessLogicLayer.Repository.Interface;
using PetScreamAspNET.Common.Log;
using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using PetScreamAspNET.DataAccessLayer.Repository;
using System;
using System.Collections.Generic;
using System.Text;

namespace PetScreamAspNET.BusinessLogicLayer.Repository.Impl
{
    public class UserRepo:BaseRepo<User>, IUserRepo
    {
        public UserRepo(PetScreamDbContext context, ILoggerService loggerService) : base(context, loggerService)
        {

        }
    }
}
