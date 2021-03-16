using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PetScreamAspNET.Common.Utils
{
    public static class Messages
    {
        public static readonly string InvalidCredentials_404NotFound = "Invalid credentials!";
        public static readonly string InsufficientStock_404NotFound = "Insufficient stock!";
        public static readonly string NotFound_4040NotFound = "Not found!";
        public static readonly string SthWentWrong_400BadRequest = "Something went wrong! Please try again";
        public static readonly string NoContent_204NoContent = "No content! Try again.";
        public static readonly string UserAlreadyExistLogin_409Conflict = "A user has already been created using this email address!";
        public static readonly string AlreadyCreated_409Conflict = "You already create this item!";
        public static readonly string AlreadyExist_409Conflict = "This item has already been created using this name!";
        public static readonly string Success_200Ok = "Success!";
        public static readonly string Created_201Ok = "Created!";

    }
}
