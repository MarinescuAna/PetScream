using System;
using System.Collections.Generic;
using System.Text;

namespace PetScreamAspNET.Common.Log
{
    public interface ILoggerService
    {
        void LogError(string path, string message);
    }
}
