-- https://dev.languagetool.org/finding-errors-using-n-gram-data.html
return {
  ltex = {
    additionalRules = {
      languageModel = "~/.ngrams/",
    },
  },
}
