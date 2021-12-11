# Functions and tools for manually computing a sentiment index

import gensim
import pandas as pd

stress_words = ["very", "totally", "much", "highly", "extremely", "remarkably", "truly", "awfully", "bloody", "entirely",
                "genuinely", "really", "seriously", "strongly", "ultimately", ]

def sent_to_words(sentences):
    gen_sim_pre_pro = gensim.utils.simple_preprocess
    for sentence in sentences:
        yield (gen_sim_pre_pro(str(sentence), deacc=True))


def flatten_list(lists):
    return [i for j in lists for i in j]


def load_pos_neg_words(directory, pos_neg_to_exclude, pos_to_include, neg_to_include):
    with open(rf'{directory}/negative-words.txt', encoding="ISO-8859-1") as f:
        neg = f.read()
    with open(rf'{directory}/positive-words.txt', encoding="ISO-8859-1") as f:
        pos = f.read()

    negative_words = neg.split('\n')[31:-2]
    positive_words = pos.split('\n')[31:-2]
    negative_words = [w for w in negative_words if w not in pos_neg_to_exclude]
    positive_words = [w for w in positive_words if w not in pos_neg_to_exclude]
    negative_words += neg_to_include
    positive_words += pos_to_include
    return positive_words,negative_words


def get_sentiment(sentence, positive_words, negative_words):
    pos_match = 0
    neg_match = 0

    for word in sentence.split():
        if word in positive_words:
            pos_match += 1
        if word in negative_words:
            neg_match += 1
        else:
            continue
    try:
        sentiment = ((neg_match - pos_match)/(neg_match + pos_match)+1)/2
    except ZeroDivisionError:
        sentiment = 0.5
    return sentiment


def get_sentiment_distribution(words, vocab_directory, pos_neg_to_exclude, pos_to_include, neg_to_include):
    """
    calculates sentiment for a collection of sentences/words
    and also collects the responsible words
    """
    positive_words, negative_words = load_pos_neg_words(vocab_directory, pos_neg_to_exclude , pos_to_include, neg_to_include)

    if words:
        words = words.split('\n')
        data_words = list(sent_to_words(words))
        data_words = flatten_list(data_words)
    else:
        data_words = []
    pos_match = 0
    pos_list = []
    neg_match = 0
    neg_list = []
    if not data_words:
        return (-1, -1, -1, -1)

    pos_list_append = pos_list.append
    neg_list_append = neg_list.append
    for w in data_words:
        if w in positive_words:
            pos_list_append(w)
            pos_match += 1
        elif w in negative_words:
            neg_list_append(w)
            neg_match += 1
        else:
            pass
    try:
        # formula p.7 paper Ardina(2020)
        sentiment = ((neg_match - pos_match)/(neg_match + pos_match)+1)/2
    except ZeroDivisionError:
        # if no sentiment words are found set sentiment to neutral
        sentiment = 0.5
    return pos_list, neg_list, sentiment, len(data_words)


def get_df_sentiment(df, column, vocab_directory, pos_neg_to_exclude=[],
                     pos_to_include=[], neg_to_include=[], risk_words=[],
                     negation=True):
    """
    adds a sentiment column to a dataframe
    arguments:
        df -- (pandas dataframe) dataframe containing columns with text 
        column -- (string) name of the investigated column
        vocab_directory -- (string) directory of the sentiment vocabulary
        pos_neg_to_exclude -- (list<string>) words that are in sentiment vocabulary but should be ignored
        pos_to_include -- (list<string>) words that are  not in sentiment vocabulary but should be included
        neg_to_include -- (list<string>) - "" -
    """
    df_sentiment = df[[column]].apply(lambda x: get_sentiment_distribution(x[0], vocab_directory, pos_neg_to_exclude,
                                                                               pos_to_include, neg_to_include), axis=1, result_type='expand')
    df_sentiment.columns = ['Positive', 'Negative', 'Sentiment', 'Count']
    df = pd.concat([df, df_sentiment], axis=1)
    return df