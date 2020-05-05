# esa-pdf-generator

## 1. build docker image
```
$ docker build -t esa-shiny:1.0 .
```


## 2. run docker container

```
$ docker-compose up -d
```

## 3. use shiny application

* Update ESA_API_KEY and ESA_TEAM_NAME in esa_info.csv
* Access `localhost:3838/esa` or `[YourIP]:3838/esa`
