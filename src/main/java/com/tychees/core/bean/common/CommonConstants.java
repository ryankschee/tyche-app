package com.tychees.core.bean.common;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.JsonNode;

@JsonFormat(shape = JsonFormat.Shape.OBJECT)
public enum CommonConstants {

	NEW("Right off the lot"),
    USED("Has had several owners"),
    ANTIQUE("Over 25 years old");

    public String description;

    CommonConstants(String description) {
        this.description = description;
    }

    // [2]
    @JsonCreator
    public static CommonConstants fromNode(JsonNode node) {
        if (!node.has("name"))
            return null;

        String name = node.get("name").asText();

        return CommonConstants.valueOf(name);
    }

    // [3]
    @JsonProperty
    public String getName() {
        return name();
    }
}
