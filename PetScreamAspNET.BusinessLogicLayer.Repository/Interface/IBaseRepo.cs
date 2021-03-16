using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;
using System.Threading.Tasks;

namespace PetScreamAspNET.BusinessLogicLayer.Repository.Interface
{
    public interface IBaseRepo<T>
    {
        Task<IEnumerable<T>> GetItemsAsync();
        Task<T> GetItemAsync(Expression<Func<T, Boolean>> expression);
        void InsertItemAsync(T item);
        Task<bool> UpdateItemAsync(Expression<Func<T, bool>> expression, T item);
        Task<bool> DeleteItemAsync(Expression<Func<T, bool>> expression, T obj);
    }
}
