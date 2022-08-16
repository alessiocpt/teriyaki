import os
import openai

def GPT_Completion(texts):## Call the API key under your account (in a secure way)
    openai.api_key = "***REMOVED***"

    response = openai.Completion.create(engine="text-davinci-002",
                                        prompt =  texts,
                                        temperature = 0.6,
                                        top_p = 1,
                                        max_tokens = 64,
                                        frequency_penalty = 0,
                                        presence_penalty = 0)return print(response.choices[0].text)
    
    return print(response.choices[0].text)