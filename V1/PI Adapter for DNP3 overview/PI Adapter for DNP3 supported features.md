---
uid: PIAdapterForDNP3SupportedFeatures
---

# PI Adapter for DNP3 supported features

## Supported DNP point types

You may configure PI Adapter for DNP3 to read data from each of the following point types as defined in the DNP3 specification. The conformance level defined for a request of each of these points is also listed. Responses may be considered a different conformance level. Refer to the DNP3 specification for more details.

**Note:** It is important that you do not configure the adapter to request data for point types that are unsupported by your outstation. 

| DNP3 point type | Static object group | Static object variations | Event object group | Event object group variations | DNP3 conformance level | 
| --------------- | ------------------- | ------------------------ | ------------------ | ----------------------------- | ---------------------- |
| `Binary Input` | 0, 1 | 0, 1, 2 | 2 | 1, 2, 3 | Level 1 |
| `Double-bit Binary Input` | 3 | 0, 1, 2, 3 | 4 | 1, 2, 3 | Level 4 | 
| `Counter` | 20 | 0, 1, 2, 3, 4, 5, 6, 7, 8 | 22 | 1, 2, 3, 4, 5, 6, 7, 8 | Level 1 |
| `Analog Input` | 30 | 0, 1, 2, 3, 4, 5, 6 | 32 | 1, 2, 3, 4, 5, 6, 7, 8 | Level 2 |
| `Octet String`<sup>1</sup> | 110 | 0 - 255 | 111 | 1 - 255 | Not required for any conformance level. |

Note that some variations may include a flag octet to indicate status. While the PI Adapter for DNP3 can parse this data, storing this data is not currently supported. In addition, variation zero has a special meaning in DNP3. The adapter may be configured request variation zero for static scans, and the outstation should return data in a variation that it prefers. The outstation is not allowed to specify variation zero in its response. The adapter will not request a specific variation for event data, but it will be able to parse any of the variations listed above. 

**<sup>1</sup>Note:** Although the Octet String point type is supported by the adapter, if the value returned by the outstation contains any `null` characters (for example, ASCII `0x00`), the string will be truncated at the first `null` character.