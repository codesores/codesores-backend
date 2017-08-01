require 'rest-client'

WATSON_SECRET = ENV['WATSON_SECRET']
WATSON_USERNAME = ENV['WATSON_USERNAME']
WATSON_URL = ENV['WATSON_URL']

#UPLOAD TRAINING DATA
# curl -i --user "{username}":"{password}" -F training_data=@{path_to_file}/weather_data_train.csv -F training_metadata="{\"language\":\"en\",\"name\":\"TutorialClassifier\"}" "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers"


# CHECK TRAINING STATUS
# curl --user "{username}":"{password}" "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/{classifier_id}"


# QUERY API
# curl -G --user "{username}":"{password}" "https://gateway.watsonplatform.net/natural-language-classifier/api/v1/classifiers/{classifier_id}/classify" --data-urlencode "text=How hot will it be today?"


