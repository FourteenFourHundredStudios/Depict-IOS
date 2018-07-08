class component {

    constructor(){

        __depict__(this.depict())
    }

    depict(){
        return {}
    }

}

print("depict started")

enums = {

    "HORIZONTAL" : 0,
    "VERTICAL" : 1

}


propertyMap = {

    "value" : {
        "android" : ["setText","getText"],
        "ios" : "text",
    },

    "hint" : {
        "android" : ["setHint","getHint"],
        "ios" : "placeholder",
    },

    "orientation" : {
        "android" : ["setOrientation","getOrientation"],
        "ios" : "axis",
    },
}
