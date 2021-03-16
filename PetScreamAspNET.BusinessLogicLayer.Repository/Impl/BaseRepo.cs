using Microsoft.EntityFrameworkCore;
using PetScreamAspNET.BusinessLogicLayer.Repository.Interface;
using PetScreamAspNET.Common.Log;
using PetScreamAspNET.DataAccessLayer.Repository;
using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace PetScreamAspNET.BusinessLogicLayer.Repository.Impl
{
    public class BaseRepo<T> : IBaseRepo<T> where T : class
    {
        protected readonly PetScreamDbContext _context;
        protected readonly ILoggerService _loggerService;
        public BaseRepo(PetScreamDbContext context, ILoggerService loggerService)
        {
            _loggerService = loggerService;
            _context = context;
        }

        public async Task<bool> DeleteItemAsync(Expression<Func<T, bool>> expression, T obj)
        {
            try
            {
                T itemFind;
                if (obj == null)
                {
                    itemFind = await GetItemAsync(expression);

                    if (itemFind == null)
                    {
                        return false;
                    }
                }
                else
                {
                    itemFind = obj;
                }
                _context.Set<T>().Remove(itemFind);

                return true;
            }
            catch (Exception ex)
            {
                _loggerService.LogError("Delete", ex.Message);
                if (!string.IsNullOrEmpty(ex?.InnerException?.Message))
                {
                    _loggerService.LogError("Delete inner exception", ex.InnerException.Message);
                }
                return false;
            }
        }
        public virtual async Task<T> GetItemAsync(Expression<Func<T, bool>> expression)
        {
            try
            {
                var temp = await _context.Set<T>().AsNoTracking().SingleOrDefaultAsync(expression);

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
        public virtual async Task<IEnumerable<T>> GetItemsAsync()
        {
            try
            {
                var temp = await _context.Set<T>().AsNoTracking().ToListAsync();

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
        public async void InsertItemAsync(T item)
        {
            try
            {
                await _context.Set<T>().AddAsync(item);

            }
            catch (Exception ex)
            {
                _loggerService.LogError("Insert", ex.Message);
                if (!string.IsNullOrEmpty(ex?.InnerException?.Message))
                {
                    _loggerService.LogError("Insert inner exception", ex.InnerException.Message);
                }
            }
        }

        public async Task<bool> UpdateItemAsync(Expression<Func<T, bool>> expression, T item)
        {
            try
            {
                T itemFind = await GetItemAsync(expression);

                if (itemFind == null)
                {
                    return false;
                }

                itemFind = item;

                _context.Set<T>().Update(itemFind);

                return true;
            }
            catch (Exception ex)
            {
                _loggerService.LogError("Update", ex.Message);

                if (!string.IsNullOrEmpty(ex?.InnerException?.Message))
                {
                    _loggerService.LogError("Update inner exception", ex.InnerException.Message);
                }

                return false;
            }

        }
    }
}
