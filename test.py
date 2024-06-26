# # #print(len("1110011100100000000000000000000000000000000000000000"))

# # # def show(y):
# # #     print(y)

# # def show_2(y, z):
# #     return y + str(z)

# # # d = show("Hello World")
# # # print(d)


# # def multiply(a, b):
# #     result = a * b
# #     return result

# # def sum_and_multiply(a, b, c):
# #     sum_result = a + b
# #     multiply_result = multiply(sum_result, c)
# #     return multiply_result

# # x = 5
# # y = 3
# # z = 2

# # final_result = sum_and_multiply(x, y, z)
# # last_result = show_2("The result is: ", final_result)
# # print(final_result)

# def factorial(n):
#     if n == 0:
#         return 1
#     else:
#         recurse = factorial(n-1)
#         result = n * recurse
#         return result

# def binomial_coefficient(n, k):
#     if k == 0 or k == n:
#         return 1
#     else:
#         factor1 = factorial(n)
#         factor2 = factorial(k)
#         factor3 = factorial(n-k)
#         result = factor1 // (factor2 * factor3)
#         return result

# n = 5
# k = 3

# final_result = binomial_coefficient(n, k)
# print(final_result)

# 11000110110110000000000000000000

# 00111110111000000000000000000000

import random

num = random.randint(1,1000)

guess = 0


while True:
    guess = int(input("Guess.."))

    if guess == num:
        print("Genius")
        break

    if guess > num:
        print("Go low low low \a")
    else:
        print("Haya haya haya \a")

