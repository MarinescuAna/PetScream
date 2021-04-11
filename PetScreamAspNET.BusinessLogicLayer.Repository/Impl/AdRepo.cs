using Microsoft.EntityFrameworkCore;
using PetScreamAspNET.BusinessLogicLayer.Repository.Interface;
using PetScreamAspNET.Common.Log;
using PetScreamAspNET.DataAccessLayer.Domain.Domain;
using PetScreamAspNET.DataAccessLayer.Repository;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace PetScreamAspNET.BusinessLogicLayer.Repository.Impl
{
    public class AdRepo: BaseRepo<Post>, IAdRepo
    {
        public AdRepo(PetScreamDbContext context, ILoggerService loggerService) : base(context, loggerService)
        {

        }

        public override async Task<Post> GetItemAsync(Expression<Func<Post, bool>> expression)
        {
            try
            {
                var temp = await _context.Set<Post>().Include("Image").AsNoTracking().FirstOrDefaultAsync(expression);

                return temp;
            }
            catch (Exception ex)
            {
                _loggerService.LogError("Get Item", ex.Message);
                if (!string.IsNullOrEmpty(ex?.InnerException?.Message))
                {
                    _loggerService.LogError("Get Item inner exception", ex.InnerException.Message);
                }
                return null;
            }

        }
        public override async Task<IEnumerable<Post>> GetItemsAsync()
        {
            try
            {
                var temp = await _context.Set<Post>().Include("Image").AsNoTracking().ToListAsync();

                return temp;
            }
            catch (Exception ex)
            {
                _loggerService.LogError("Get Items", ex.Message);
                if (!string.IsNullOrEmpty(ex?.InnerException?.Message))
                {
                    _loggerService.LogError("Get Items inner exception", ex.InnerException.Message);
                }
                return null;
            }
        }
    }
}
