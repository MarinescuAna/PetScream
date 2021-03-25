using PetScreamAspNET.BusinessLogicLayer.Repository.Interface;
using PetScreamAspNET.Common.Log;
using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using PetScreamAspNET.DataAccessLayer.Repository;
using System;
using System.Collections.Generic;
using System.Text;

namespace PetScreamAspNET.BusinessLogicLayer.Repository.Impl
{
    public class AdRepo: BaseRepo<Post>, IAdRepo
    {
        public AdRepo(PetScreamDbContext context, ILoggerService loggerService) : base(context, loggerService)
        {

        }
    }
}
