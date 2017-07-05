{
  "sbg:validationErrors": [],
  "class": "Workflow",
  "sbg:sbgMaintained": false,
  "sbg:project": "christian_frech/dev",
  "sbg:modifiedOn": 1495725354,
  "requirements": [],
  "cwlVersion": "sbg:draft-2",
  "steps": [
    {
      "id": "#SBG_FASTA_Indices",
      "run": {
        "sbg:validationErrors": [],
        "class": "CommandLineTool",
        "successCodes": [],
        "sbg:sbgMaintained": false,
        "sbg:toolAuthor": "Sanja Mijalkovic, Seven Bridges Genomics, <sanja.mijalkovic@sbgenomics.com>",
        "sbg:id": "bix-demo/sbgtools-demo/sbg-fasta-indices/5",
        "sbg:project": "bix-demo/sbgtools-demo",
        "arguments": [
          {
            "valueFrom": "--dict",
            "separate": true
          },
          {
            "valueFrom": "--fai",
            "separate": true
          }
        ],
        "sbg:job": {
          "inputs": {
            "reference": {
              "class": "File",
              "path": "/path/to/reference.ext",
              "size": 0,
              "secondaryFiles": []
            }
          },
          "allocatedResources": {
            "mem": 2500,
            "cpu": 1
          }
        },
        "sbg:modifiedOn": 1458669249,
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "cwlVersion": "sbg:draft-2",
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerPull": "images.sbgenomics.com/djordje_klisic/sbg-fasta-indices:1.0",
            "dockerImageId": "b177f5bd06db"
          },
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 2500
          }
        ],
        "sbg:categories": [
          "Indexing"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1450911283,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1450911283,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1458655251,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 3,
            "sbg:modifiedOn": 1458655509,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "markop",
            "sbg:revision": 4,
            "sbg:modifiedOn": 1458658019,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "markop",
            "sbg:revision": 5,
            "sbg:modifiedOn": 1458669249,
            "sbg:revisionNotes": null
          }
        ],
        "sbg:image_url": null,
        "sbg:createdBy": "bix-demo",
        "temporaryFailCodes": [],
        "outputs": [
          {
            "outputBinding": {
              "secondaryFiles": [
                ".fai",
                "^.dict"
              ],
              "glob": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  return $job.inputs.reference.path.split(\"/\").pop()\n}"
              },
              "sbg:inheritMetadataFrom": "#reference"
            },
            "label": "Reference",
            "id": "#fasta_reference",
            "type": [
              "null",
              "File"
            ],
            "sbg:fileTypes": "FASTA"
          },
          {
            "outputBinding": {
              "glob": "*.fai",
              "sbg:metadata": {}
            },
            "label": "FASTA Index",
            "id": "#fasta_index",
            "type": [
              "null",
              "File"
            ],
            "sbg:fileTypes": "FAI"
          },
          {
            "outputBinding": {
              "glob": "*.dict",
              "sbg:metadata": {}
            },
            "label": "FASTA Dictionary",
            "id": "#fasta_dict",
            "type": [
              "null",
              "File"
            ],
            "sbg:fileTypes": "DICT"
          }
        ],
        "baseCommand": [
          "python",
          "/opt/sbg-fasta-indices.py"
        ],
        "sbg:modifiedBy": "markop",
        "id": "bix-demo/sbgtools-demo/sbg-fasta-indices/5",
        "stdout": "",
        "stdin": "",
        "sbg:license": "Apache License 2.0",
        "sbg:createdOn": 1450911283,
        "x": 213.6666666666667,
        "y": 527.0000000000001,
        "sbg:revision": 5,
        "inputs": [
          {
            "id": "#reference",
            "inputBinding": {
              "sbg:cmdInclude": true,
              "prefix": "--REFERENCE",
              "separate": true
            },
            "label": "FASTA file",
            "description": "FASTA file to be indexed",
            "required": true,
            "type": [
              "File"
            ],
            "sbg:stageInput": "link"
          }
        ],
        "sbg:toolkit": "SBGTools",
        "sbg:latestRevision": 5,
        "sbg:cmdPreview": "python /opt/sbg-fasta-indices.py --REFERENCE /path/to/reference.ext  --dict  --fai",
        "label": "SBG FASTA Indices",
        "description": "Tool allows creating FASTA dictionary and index simultaneously which is necessary for running GATK tools. This version of tool for indexing uses SAMtools faidx command (toolkit version0.1.19), while for the FASTA dictionary is used Picard CreateFastaDictionary (toolkit version 1.140)",
        "sbg:contributors": [
          "markop",
          "bix-demo"
        ]
      },
      "sbg:x": 213.6666666666667,
      "inputs": [
        {
          "id": "#SBG_FASTA_Indices.reference",
          "source": [
            "#reference"
          ]
        }
      ],
      "outputs": [
        {
          "id": "#SBG_FASTA_Indices.fasta_reference"
        },
        {
          "id": "#SBG_FASTA_Indices.fasta_index"
        },
        {
          "id": "#SBG_FASTA_Indices.fasta_dict"
        }
      ],
      "sbg:y": 527.0000000000001
    },
    {
      "id": "#Sambamba_Index_1",
      "run": {
        "sbg:validationErrors": [],
        "class": "CommandLineTool",
        "sbg:links": [
          {
            "id": "http://lomereiter.github.io/sambamba/docs/sambamba-view.html",
            "label": "Homepage"
          },
          {
            "id": "https://github.com/lomereiter/sambamba",
            "label": "Source code"
          },
          {
            "id": "https://github.com/lomereiter/sambamba/wiki",
            "label": "Wiki"
          },
          {
            "id": "https://github.com/lomereiter/sambamba/releases/tag/v0.5.9",
            "label": "Download"
          },
          {
            "id": "http://lomereiter.github.io/sambamba/docs/sambamba-view.html",
            "label": "Publication"
          }
        ],
        "sbg:sbgMaintained": false,
        "sbg:toolAuthor": "Artem Tarasov",
        "sbg:id": "bix-demo/sambamba-0-5-9-demo/sambamba-index-0-5-9/8",
        "sbg:project": "bix-demo/sambamba-0-5-9-demo",
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "class": "Expression",
              "script": "{\n  if ((!(typeof $job.inputs.input_bai_file !== \"undefined\")))\n  {\n  if ($job.inputs.input_bam)\n  {\n    \n    filepath = $job.inputs.input_bam.path\n   \tfilename = filepath.split('/').slice(-1)[0]\n    \n    index_name = filename.concat(\".bai\")\n    \n    return index_name\n  }\n}\n}\n\n"
            },
            "position": 100,
            "prefix": "",
            "separate": true
          }
        ],
        "sbg:job": {
          "inputs": {
            "check_bins": false,
            "mem_mb": 2,
            "input_bam": {
              "path": "/root/dir/example.bam"
            },
            "redundancy": true,
            "cram_input": false,
            "nthreads": 4
          },
          "allocatedResources": {
            "mem": 2,
            "cpu": 4
          }
        },
        "sbg:modifiedOn": 1475064216,
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "cwlVersion": "sbg:draft-2",
        "sbg:cmdPreview": "/opt/sambamba_0.5.9/sambamba_v0.5.9 index  example.bam  example.bam.bai",
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerPull": "images.sbgenomics.com/mladenlsbg/sambamba:0.5.9",
            "dockerImageId": "59e577b13d5d"
          },
          {
            "class": "sbg:CPURequirement",
            "value": {
              "engine": "#cwl-js-engine",
              "class": "Expression",
              "script": "{\n  if (!(typeof $job.inputs.input_bai_file !== \"undefined\"))\n  {\n    if ($job.inputs.nthreads)\n    \treturn $job.inputs.nthreads\n\telse\n    \treturn 8\n  }\n}"
            }
          },
          {
            "class": "sbg:MemRequirement",
            "value": {
              "engine": "#cwl-js-engine",
              "class": "Expression",
              "script": "{\n  if ($job.inputs.mem_mb) {\n    \n    return $job.inputs.mem_mb\n    \n  } else {\n    \n    return 1024\n    \n  }\n  \n}"
            }
          }
        ],
        "sbg:categories": [
          "SAM/BAM-Processing",
          "Indexing"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1450911564,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1450911565,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1450911565,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 3,
            "sbg:modifiedOn": 1450911566,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "mladenlSBG",
            "sbg:revision": 4,
            "sbg:modifiedOn": 1460027051,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "mladenlSBG",
            "sbg:revision": 5,
            "sbg:modifiedOn": 1462972481,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 6,
            "sbg:modifiedOn": 1468850649,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 7,
            "sbg:modifiedOn": 1470135900,
            "sbg:revisionNotes": "Avoiding redundancy"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 8,
            "sbg:modifiedOn": 1475064216,
            "sbg:revisionNotes": "Changed resource entries"
          }
        ],
        "sbg:license": "GNU General Public License v2.0 only",
        "sbg:createdBy": "bix-demo",
        "temporaryFailCodes": [],
        "outputs": [
          {
            "id": "#indexed_bam",
            "sbg:fileTypes": "BAM",
            "outputBinding": {
              "secondaryFiles": [
                "^.bai",
                ".bai"
              ],
              "glob": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if ($job.inputs.redundancy === false) {\n    \n    return ''\n    \n  } else {\n    \n    return '*.bam'\n    \n  }\n}"
              },
              "sbg:inheritMetadataFrom": "#input_bam"
            },
            "label": "Indexed BAM file",
            "description": "Bam file.",
            "type": [
              "null",
              "File"
            ]
          },
          {
            "id": "#index",
            "sbg:fileTypes": "BAI",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#input_bam",
              "glob": "*.bai"
            },
            "label": "Index file",
            "description": "Indexed file.",
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "sbg:toolkitVersion": "0.5.9",
        "baseCommand": [
          {
            "engine": "#cwl-js-engine",
            "class": "Expression",
            "script": "{\n  if (typeof $job.inputs.input_bai_file !== \"undefined\"){\n \treturn\"echo Skipping index step because BAI file is provided on the input.\"\n  }\n  else{\n    return \"/opt/sambamba_0.5.9/sambamba_v0.5.9 index\"\n  }\n}"
          }
        ],
        "sbg:modifiedBy": "ognjenm",
        "id": "bix-demo/sambamba-0-5-9-demo/sambamba-index-0-5-9/8",
        "sbg:revisionNotes": "Changed resource entries",
        "stdout": "",
        "stdin": "",
        "sbg:createdOn": 1450911564,
        "x": 388.3333333333334,
        "y": 430.6666768391928,
        "sbg:revision": 8,
        "inputs": [
          {
            "id": "#redundancy",
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "TRUE",
            "label": "Output input BAM",
            "description": "Send the input BAM to the output thus creating redundant data.",
            "sbg:stageInput": null,
            "type": [
              "null",
              "boolean"
            ]
          },
          {
            "id": "#nthreads",
            "sbg:altPrefix": "-t",
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "8",
            "label": "Number of threads",
            "description": "Number of threads to use.",
            "inputBinding": {
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if (!(typeof $job.inputs.input_bai_file !== \"undefined\"))\n  {\n    if ($job.inputs.nthreads)\n    \treturn $job.inputs.nthreads\n\telse\n    \treturn 8\n  }\n}\n\n"
              },
              "sbg:cmdInclude": true,
              "prefix": "--nthreads=",
              "separate": false
            },
            "type": [
              "null",
              "int"
            ]
          },
          {
            "id": "#mem_mb",
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "1024",
            "label": "Memory in MB",
            "description": "Memory in MB.",
            "sbg:stageInput": null,
            "type": [
              "null",
              "int"
            ]
          },
          {
            "id": "#input_bam",
            "sbg:category": "File input",
            "sbg:fileTypes": "BAM, CRAM",
            "required": true,
            "label": "Input file",
            "description": "BAM or CRAM file.",
            "inputBinding": {
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if ((!(typeof $job.inputs.input_bai_file !== \"undefined\")))\n  {\n    return $job.inputs.input_bam.path.split('/').slice(-1)[0]\n  }\n}"
              },
              "position": 99,
              "sbg:cmdInclude": true,
              "itemSeparator": " ",
              "separate": true
            },
            "type": [
              "File"
            ],
            "sbg:stageInput": "link"
          },
          {
            "id": "#input_bai_file",
            "sbg:category": "File input",
            "sbg:fileTypes": "BAI",
            "label": "Input BAI(BAM index) file",
            "description": "Input BAI(BAM index) file.",
            "required": false,
            "type": [
              "null",
              "File"
            ],
            "sbg:stageInput": "link"
          },
          {
            "id": "#cram_input",
            "sbg:category": "Execution",
            "label": "CRAM input",
            "description": "Specify that input is in CRAM format.",
            "inputBinding": {
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if ((!(typeof $job.inputs.input_bai_file !== \"undefined\")) && ($job.inputs.cram_input === true))\n  {\n    return \"--cram-input\" \n  }\n}"
              },
              "sbg:cmdInclude": true,
              "itemSeparator": null,
              "separate": true
            },
            "type": [
              "null",
              "boolean"
            ]
          },
          {
            "id": "#check_bins",
            "sbg:altPrefix": "c",
            "sbg:category": "Execution",
            "label": "Check bins",
            "description": "Check that bins are set correctly.",
            "inputBinding": {
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if ((!(typeof $job.inputs.input_bai_file !== \"undefined\")) && ($job.inputs.check_bins === true))\n  {\n    return \"--check-bins\" \n  }\n}"
              },
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "boolean"
            ]
          }
        ],
        "sbg:toolkit": "Sambamba",
        "sbg:latestRevision": 8,
        "successCodes": [],
        "sbg:image_url": null,
        "label": "Sambamba Index",
        "description": "Sambamba Index creates an index for a BAM or CRAM file.",
        "sbg:contributors": [
          "ognjenm",
          "mladenlSBG",
          "bix-demo"
        ]
      },
      "sbg:x": 388.3333333333334,
      "inputs": [
        {
          "default": true,
          "id": "#Sambamba_Index_1.redundancy"
        },
        {
          "default": 7,
          "id": "#Sambamba_Index_1.nthreads"
        },
        {
          "default": 14000,
          "id": "#Sambamba_Index_1.mem_mb"
        },
        {
          "id": "#Sambamba_Index_1.input_bam",
          "source": [
            "#tumor_bam"
          ]
        },
        {
          "id": "#Sambamba_Index_1.input_bai_file"
        },
        {
          "id": "#Sambamba_Index_1.cram_input"
        },
        {
          "id": "#Sambamba_Index_1.check_bins"
        }
      ],
      "outputs": [
        {
          "id": "#Sambamba_Index_1.indexed_bam"
        },
        {
          "id": "#Sambamba_Index_1.index"
        }
      ],
      "sbg:y": 430.6666768391928
    },
    {
      "id": "#SBG_Compressor",
      "run": {
        "sbg:validationErrors": [],
        "class": "CommandLineTool",
        "successCodes": [],
        "sbg:sbgMaintained": false,
        "sbg:toolAuthor": "Marko Petkovic, Seven Bridges Genomics",
        "sbg:id": "bix-demo/sbgtools-demo/sbg-compressor-1-0/7",
        "sbg:project": "bix-demo/sbgtools-demo",
        "arguments": [],
        "sbg:job": {
          "inputs": {
            "output_format": "BZ2",
            "input_files": [
              {
                "class": "File",
                "path": "input1/file1.ext",
                "size": 0,
                "secondaryFiles": []
              },
              {
                "path": "input1/file2.ext"
              }
            ],
            "output_name": "output_name"
          },
          "allocatedResources": {
            "mem": 1000,
            "cpu": 1
          }
        },
        "sbg:modifiedOn": 1475231451,
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "cwlVersion": "sbg:draft-2",
        "sbg:cmdPreview": "/opt/sbg_compressor.py --input_files input1/file1.ext --input_files input1/file2.ext --output_format BZ2",
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerPull": "images.sbgenomics.com/milan_domazet/sbg-compressor:1.0",
            "dockerImageId": "e0eb13970c8f"
          },
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 1000
          }
        ],
        "sbg:categories": [
          "Other"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1450911274,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1450911274,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1450911275,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 3,
            "sbg:modifiedOn": 1450911276,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "markop",
            "sbg:revision": 4,
            "sbg:modifiedOn": 1457620923,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "markop",
            "sbg:revision": 5,
            "sbg:modifiedOn": 1459261342,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "milan.domazet.sudo",
            "sbg:revision": 6,
            "sbg:modifiedOn": 1470835392,
            "sbg:revisionNotes": "Changed image to milan_domazet repo, python script is redone to take only basename so there is no folder structure in compressed archive."
          },
          {
            "sbg:modifiedBy": "nens",
            "sbg:revision": 7,
            "sbg:modifiedOn": 1475231451,
            "sbg:revisionNotes": "inherit metadata form input_files"
          }
        ],
        "sbg:license": "Apache License 2.0",
        "sbg:createdBy": "bix-demo",
        "temporaryFailCodes": [],
        "outputs": [
          {
            "id": "#output_archives",
            "sbg:fileTypes": "TAR, TAR.GZ, TAR.BZ2,  GZ, BZ2, ZIP",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#input_files",
              "glob": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  format = $job.inputs.output_format.toLowerCase()\n  return \"*.\" + format\n}"
              }
            },
            "label": "Output archives",
            "description": "Newly created archives from the input files.",
            "type": [
              {
                "items": "File",
                "type": "array",
                "name": "output_archives"
              }
            ]
          }
        ],
        "sbg:toolkitVersion": "v1.0",
        "baseCommand": [
          "/opt/sbg_compressor.py"
        ],
        "sbg:modifiedBy": "nens",
        "id": "bix-demo/sbgtools-demo/sbg-compressor-1-0/7",
        "sbg:revisionNotes": "inherit metadata form input_files",
        "stdout": "",
        "stdin": "",
        "sbg:createdOn": 1450911274,
        "x": 1324.6156641604753,
        "y": 465.84627136817875,
        "sbg:revision": 7,
        "inputs": [
          {
            "id": "#output_name",
            "sbg:toolDefaultValue": "output_archive",
            "label": "Output name",
            "description": "Base name of the output archive. This parameter is not applicable for the GZ and BZ2 file formats.",
            "inputBinding": {
              "prefix": "--output_name",
              "position": 0,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "string"
            ]
          },
          {
            "id": "#output_format",
            "description": "Format of the output archive.",
            "inputBinding": {
              "prefix": "--output_format",
              "position": 0,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "label": "Output format",
            "type": [
              {
                "type": "enum",
                "name": "output_format",
                "symbols": [
                  "TAR",
                  "TAR.GZ",
                  "TAR.BZ2",
                  "ZIP",
                  "GZ",
                  "BZ2"
                ]
              }
            ]
          },
          {
            "id": "#input_files",
            "inputBinding": {
              "prefix": "--input_files",
              "position": 0,
              "sbg:cmdInclude": true,
              "itemSeparator": null,
              "separate": true
            },
            "label": "Input files",
            "description": "The input files to be archived.",
            "required": true,
            "type": [
              {
                "items": "File",
                "type": "array",
                "name": "input_files"
              }
            ],
            "sbg:stageInput": "copy"
          }
        ],
        "sbg:contributors": [
          "bix-demo",
          "nens",
          "milan.domazet.sudo",
          "markop"
        ],
        "sbg:latestRevision": 7,
        "sbg:toolkit": "SBGTools",
        "sbg:image_url": null,
        "label": "SBG Compressor",
        "description": "SBG Compressor performs the archiving(and/or compression) of the files provided on the input. The format of the output can be selected. \n\tSupported formats are:\n\t\t1. TAR\n\t\t2. TAR.GZ \n\t\t3. TAR.BZ2\n\t\t4. GZ\n\t\t5. BZ2\n\t\t6. ZIP\nFor formats TAR, TAR.GZ, TAR.BAZ2 and ZIP, single archive will be created on the output. For formats GZ and BZ2, one archive per file will be created.",
        "sbg:homepage": "https://igor.sbgenomics.com/"
      },
      "sbg:x": 1324.6156641604753,
      "inputs": [
        {
          "default": "output",
          "id": "#SBG_Compressor.output_name"
        },
        {
          "default": "TAR",
          "id": "#SBG_Compressor.output_format"
        },
        {
          "id": "#SBG_Compressor.input_files",
          "source": [
            "#SBG_FlattenLists.output_list"
          ]
        }
      ],
      "outputs": [
        {
          "id": "#SBG_Compressor.output_archives"
        }
      ],
      "sbg:y": 465.84627136817875
    },
    {
      "id": "#cnvkit_target",
      "run": {
        "sbg:validationErrors": [],
        "class": "CommandLineTool",
        "successCodes": [],
        "sbg:sbgMaintained": false,
        "sbg:project": "milan.domazet/cnvkit-test",
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "class": "Expression",
              "script": "{\n  var fileName=$job.inputs.interval_file.path.replace(/^.*[\\\\\\/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  return fileName+\".target.bed\"\n}"
            },
            "position": 5,
            "prefix": "--output",
            "separate": true
          }
        ],
        "sbg:job": {
          "inputs": {
            "short_names": true,
            "avg_size": 9.311031254625354,
            "interval_file": {
              "class": "File",
              "path": "/path/to/interval_file.ext",
              "size": 0,
              "secondaryFiles": []
            },
            "split": true,
            "annotation_file": {
              "class": "File",
              "path": "/path/to/annotation_file.ext",
              "size": 0,
              "secondaryFiles": []
            }
          },
          "allocatedResources": {
            "mem": 1024,
            "cpu": 1
          }
        },
        "sbg:modifiedOn": 1459788127,
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "cwlVersion": "sbg:draft-2",
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
            "dockerImageId": ""
          }
        ],
        "sbg:id": "milan.domazet/cnvkit-test/cnvkit-target/3",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1459782206,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1459785464,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1459786388,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 3,
            "sbg:modifiedOn": 1459788127,
            "sbg:revisionNotes": null
          }
        ],
        "sbg:image_url": null,
        "outputs": [
          {
            "id": "#target_bed",
            "sbg:fileTypes": "BED",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#interval_file",
              "glob": "*.bed"
            },
            "label": "Target BED",
            "description": "Target BED",
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "temporaryFailCodes": [],
        "sbg:createdBy": "milan.domazet",
        "baseCommand": [
          "cnvkit.py",
          "target"
        ],
        "sbg:modifiedBy": "milan.domazet",
        "id": "milan.domazet/cnvkit-test/cnvkit-target/3",
        "stdout": "",
        "stdin": "",
        "sbg:createdOn": 1459782206,
        "x": 466.6667073567709,
        "y": 600.0000406901044,
        "sbg:revision": 3,
        "inputs": [
          {
            "id": "#split",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "False",
            "label": "Split",
            "description": "Split large tiled intervals into smaller, consecutive targets.",
            "inputBinding": {
              "prefix": "--split",
              "position": 3,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "boolean"
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#short_names",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "False",
            "label": "Short names",
            "description": "Reduce multi-accession bait labels to be short and consistent.",
            "inputBinding": {
              "prefix": "--short-names",
              "position": 2,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "boolean"
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#interval_file",
            "sbg:category": "Positional arguments",
            "sbg:fileTypes": "BED,INTERVALS,INTERVAL,LIST",
            "required": true,
            "label": "Interval file",
            "description": "BED or interval file listing the targeted regions.",
            "inputBinding": {
              "position": 0,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "File"
            ]
          },
          {
            "id": "#avg_size",
            "sbg:altPrefix": "-a",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "266.666666667",
            "label": "Average size of split target bins",
            "description": "Average size of split target bins (results are approximate).",
            "inputBinding": {
              "prefix": "--avg-size",
              "position": 4,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "float"
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#annotation_file",
            "sbg:category": "Optional arguments",
            "sbg:fileTypes": "TXT,TEXT",
            "required": false,
            "label": "Annotation file",
            "description": "UCSC refFlat.txt or ensFlat.txt file for the reference genome. Pull gene names from this file and assign them to the target regions.",
            "inputBinding": {
              "prefix": "--annotate",
              "position": 1,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "sbg:latestRevision": 3,
        "sbg:cmdPreview": "cnvkit.py target  /path/to/interval_file.ext --output interval_file.target.bed",
        "label": "cnvkit-target",
        "description": "",
        "sbg:contributors": [
          "milan.domazet"
        ]
      },
      "sbg:x": 466.6667073567709,
      "inputs": [
        {
          "id": "#cnvkit_target.split"
        },
        {
          "id": "#cnvkit_target.short_names"
        },
        {
          "id": "#cnvkit_target.interval_file",
          "source": [
            "#bed_file"
          ]
        },
        {
          "id": "#cnvkit_target.avg_size"
        },
        {
          "id": "#cnvkit_target.annotation_file",
          "source": [
            "#annotation_file"
          ]
        }
      ],
      "outputs": [
        {
          "id": "#cnvkit_target.target_bed"
        }
      ],
      "sbg:y": 600.0000406901044
    },
    {
      "id": "#cnvkit_access",
      "run": {
        "sbg:validationErrors": [],
        "class": "CommandLineTool",
        "successCodes": [],
        "sbg:sbgMaintained": false,
        "sbg:project": "milan.domazet/cnvkit-test",
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "class": "Expression",
              "script": "{\n  var fileName=$job.inputs.fa_fname.path.replace(/^.*[\\\\\\/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  return fileName+\".access.bed\"\n}"
            },
            "position": 3,
            "prefix": "--output",
            "separate": true
          }
        ],
        "sbg:job": {
          "inputs": {
            "fa_fname": {
              "class": "File",
              "path": "/path/to/fa_fname.ext",
              "size": 0,
              "secondaryFiles": []
            },
            "exclude_files": [
              {
                "class": "File",
                "path": "/path/to/exclude_files-1.ext",
                "size": 0,
                "secondaryFiles": []
              },
              {
                "class": "File",
                "path": "/path/to/exclude_files-2.ext",
                "size": 0,
                "secondaryFiles": []
              }
            ],
            "min_gap_size": 8
          },
          "allocatedResources": {
            "mem": 1024,
            "cpu": 1
          }
        },
        "sbg:modifiedOn": 1459786528,
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "cwlVersion": "sbg:draft-2",
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
            "dockerImageId": ""
          }
        ],
        "sbg:id": "milan.domazet/cnvkit-test/cnvkit-access/2",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1459785630,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1459786329,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1459786528,
            "sbg:revisionNotes": null
          }
        ],
        "sbg:image_url": null,
        "outputs": [
          {
            "id": "#access_bed",
            "sbg:fileTypes": "BED",
            "outputBinding": {
              "glob": "*.bed"
            },
            "label": "Access BED file",
            "description": "Access result BED file.",
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "temporaryFailCodes": [],
        "sbg:createdBy": "milan.domazet",
        "baseCommand": [
          "cnvkit.py",
          "access"
        ],
        "sbg:modifiedBy": "milan.domazet",
        "id": "milan.domazet/cnvkit-test/cnvkit-access/2",
        "stdout": "",
        "stdin": "",
        "sbg:createdOn": 1459785630,
        "x": 457.3333536783855,
        "y": 751.9999796549481,
        "sbg:revision": 2,
        "inputs": [
          {
            "id": "#min_gap_size",
            "sbg:altPrefix": "-s",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "5000",
            "label": "Minimum gap size",
            "description": "Minimum gap size between accessible sequence regions. Regions separated by less than this distance will be joined together.",
            "inputBinding": {
              "prefix": "--min-gap-size",
              "position": 1,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "int"
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#fa_fname",
            "sbg:category": "Positional arguments",
            "sbg:fileTypes": "FASTA,FA",
            "required": true,
            "label": "Genome FASTA file",
            "description": "Genome FASTA file.",
            "inputBinding": {
              "position": 0,
              "sbg:cmdInclude": true,
              "loadContents": false,
              "separate": true
            },
            "type": [
              "File"
            ]
          },
          {
            "id": "#exclude_files",
            "sbg:altPrefix": "-x",
            "sbg:category": "Optional arguments",
            "sbg:fileTypes": "BED",
            "required": false,
            "label": "Exclude regions",
            "description": "Additional regions to exclude, in BED format. Can be used multiple times.",
            "inputBinding": {
              "prefix": "--exclude",
              "position": 2,
              "sbg:cmdInclude": true,
              "itemSeparator": null,
              "separate": true
            },
            "type": [
              "null",
              {
                "items": "File",
                "type": "array",
                "name": "exclude_files"
              }
            ],
            "sbg:stageInput": null
          }
        ],
        "sbg:latestRevision": 2,
        "sbg:cmdPreview": "cnvkit.py access  /path/to/fa_fname.ext --output fa_fname.access.bed",
        "label": "cnvkit-access",
        "description": "",
        "sbg:contributors": [
          "milan.domazet"
        ]
      },
      "sbg:x": 457.3333536783855,
      "inputs": [
        {
          "id": "#cnvkit_access.min_gap_size"
        },
        {
          "id": "#cnvkit_access.fa_fname",
          "source": [
            "#SBG_FASTA_Indices.fasta_reference"
          ]
        },
        {
          "id": "#cnvkit_access.exclude_files"
        }
      ],
      "outputs": [
        {
          "id": "#cnvkit_access.access_bed"
        }
      ],
      "sbg:y": 751.9999796549481
    },
    {
      "id": "#cnvkit_antitarget",
      "run": {
        "sbg:validationErrors": [],
        "class": "CommandLineTool",
        "successCodes": [],
        "sbg:sbgMaintained": false,
        "sbg:project": "milan.domazet/cnvkit-test",
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "class": "Expression",
              "script": "{\n  var fileName=$job.inputs.interval_file.path.replace(/^.*[\\\\\\/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  return fileName+\".antitarget.bed\"\n}"
            },
            "prefix": "--output",
            "separate": true
          }
        ],
        "sbg:job": {
          "inputs": {
            "interval_file": {
              "class": "File",
              "path": "/path/to/bed_file.ext",
              "size": 0,
              "secondaryFiles": []
            },
            "min_size": 0.9309678755142813,
            "access_file": {
              "class": "File",
              "path": "/path/to/access_file.ext",
              "size": 0,
              "secondaryFiles": []
            },
            "avg_size": 5.955220358293964
          },
          "allocatedResources": {
            "mem": 1024,
            "cpu": 1
          }
        },
        "sbg:modifiedOn": 1459788149,
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "cwlVersion": "sbg:draft-2",
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
            "dockerImageId": ""
          }
        ],
        "sbg:id": "milan.domazet/cnvkit-test/cnvkit-antitarget/3",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1459786542,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1459787238,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1459787279,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "milan.domazet",
            "sbg:revision": 3,
            "sbg:modifiedOn": 1459788149,
            "sbg:revisionNotes": null
          }
        ],
        "sbg:image_url": null,
        "outputs": [
          {
            "id": "#antitarget_bed",
            "sbg:fileTypes": "BED",
            "outputBinding": {
              "glob": "*.bed"
            },
            "label": "Antitarget BED",
            "description": "Antitarget BED.",
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "temporaryFailCodes": [],
        "sbg:createdBy": "milan.domazet",
        "baseCommand": [
          "cnvkit.py",
          "antitarget"
        ],
        "sbg:modifiedBy": "milan.domazet",
        "id": "milan.domazet/cnvkit-test/cnvkit-antitarget/3",
        "stdout": "",
        "stdin": "",
        "sbg:createdOn": 1459786542,
        "x": 706.666666666667,
        "y": 518.666707356771,
        "sbg:revision": 3,
        "inputs": [
          {
            "id": "#min_size",
            "sbg:altPrefix": "-m",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "1/16 avg size, calculated",
            "label": "Antitarget minimum size",
            "description": "Minimum size of antitarget bins (smaller regions are dropped).",
            "inputBinding": {
              "prefix": "--min-size",
              "position": 3,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "float"
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#interval_file",
            "sbg:category": "Positional arguments",
            "sbg:fileTypes": "BED,INTERVALS,INTERVAL,LIST",
            "required": true,
            "label": "Interval file",
            "description": "BED or interval file listing the targeted regions.",
            "inputBinding": {
              "position": 0,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "File"
            ]
          },
          {
            "id": "#avg_size",
            "sbg:altPrefix": "-a",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "100000",
            "label": "Average size of antitarget bins",
            "description": "Average size of antitarget bins (results are approximate).",
            "inputBinding": {
              "prefix": "--avg-size",
              "position": 2,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "float"
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#access_file",
            "sbg:altPrefix": "-g",
            "sbg:category": "Optional arguments",
            "sbg:fileTypes": "BED",
            "required": false,
            "label": "Access file",
            "description": "Regions of accessible sequence on chromosomes (.bed), as output by genome 2 access.",
            "inputBinding": {
              "prefix": "--access",
              "position": 1,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "sbg:latestRevision": 3,
        "sbg:cmdPreview": "cnvkit.py antitarget  /path/to/bed_file.ext --output bed_file.antitarget.bed",
        "label": "cnvkit-antitarget",
        "description": "",
        "sbg:contributors": [
          "milan.domazet"
        ]
      },
      "sbg:x": 706.666666666667,
      "inputs": [
        {
          "id": "#cnvkit_antitarget.min_size"
        },
        {
          "id": "#cnvkit_antitarget.interval_file",
          "source": [
            "#cnvkit_target.target_bed"
          ]
        },
        {
          "id": "#cnvkit_antitarget.avg_size"
        },
        {
          "id": "#cnvkit_antitarget.access_file",
          "source": [
            "#cnvkit_access.access_bed"
          ]
        }
      ],
      "outputs": [
        {
          "id": "#cnvkit_antitarget.antitarget_bed"
        }
      ],
      "sbg:y": 518.666707356771
    },
    {
      "id": "#Prefixer_3",
      "run": {
        "sbg:validationErrors": [],
        "class": "CommandLineTool",
        "successCodes": [],
        "sbg:sbgMaintained": false,
        "sbg:project": "ognjenm/tn-validation",
        "arguments": [],
        "sbg:job": {
          "inputs": {
            "files": [
              {
                "class": "File",
                "path": "/path/to/files-1.ext",
                "size": 0,
                "secondaryFiles": []
              },
              {
                "class": "File",
                "path": "/path/to/files-2.ext",
                "size": 0,
                "secondaryFiles": []
              }
            ],
            "prefix": "prefix-string-value"
          },
          "allocatedResources": {
            "mem": 1000,
            "cpu": 1
          }
        },
        "sbg:modifiedOn": 1476132485,
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "cwlVersion": "sbg:draft-2",
        "hints": [
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 1000
          },
          {
            "class": "DockerRequirement",
            "dockerPull": "ubuntu:14.04",
            "dockerImageId": ""
          }
        ],
        "sbg:id": "ognjenm/tn-validation/prefixer/3",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1475926710,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1475927767,
            "sbg:revisionNotes": "Initial"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1475935504,
            "sbg:revisionNotes": "Added flatten function"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 3,
            "sbg:modifiedOn": 1476132485,
            "sbg:revisionNotes": "Protected from null"
          }
        ],
        "sbg:image_url": null,
        "outputs": [
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#files",
              "glob": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  \n  return $job.inputs.prefix + '.*'\n  \n}"
              }
            },
            "id": "#renamed",
            "type": [
              "null",
              {
                "items": "File",
                "type": "array",
                "name": "renamed"
              }
            ]
          }
        ],
        "temporaryFailCodes": [],
        "sbg:createdBy": "ognjenm",
        "baseCommand": [
          ""
        ],
        "sbg:modifiedBy": "ognjenm",
        "id": "ognjenm/tn-validation/prefixer/3",
        "sbg:revisionNotes": "Protected from null",
        "stdout": "",
        "stdin": "",
        "sbg:createdOn": 1475926710,
        "x": 1016.1028051884321,
        "y": 429.12832731326506,
        "sbg:revision": 3,
        "inputs": [
          {
            "id": "#prefix",
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "Empty string",
            "required": true,
            "label": "Prefix",
            "description": "String to add as prefix when renaming the input files",
            "inputBinding": {
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  \n    function flatten(array){\n  \n\n  \n \t for(i=0;i<array.length;i++) {\n   \t\t if (array[i] instanceof Array) {\n    \t\tarray = array.concat(array[i])\n        \t\tarray.splice(i, 1)\n        i -= 1\n  \t  \t}\n \t }\n  \n \t return array\n  \n\t}\n  \n  inputs = flatten([].concat($job.inputs.files));\n  cmd =''\n  \n  for (i = 0; i < inputs.length; i++) {\n    if (inputs[i]){\n    new_name = $job.inputs.prefix + '.' + inputs[i].path.split('/').pop()\n    cmd += 'cp ' + inputs[i].path + ' ' + new_name + '; '\n    }\n\t}\n  \n return cmd \n  \n  \n}"
              },
              "position": 2,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "string"
            ]
          },
          {
            "id": "#files",
            "sbg:category": "Execution",
            "label": "Files",
            "description": "List o files to be renamed with a prefix.",
            "required": false,
            "type": [
              "null",
              {
                "items": "File",
                "type": "array",
                "name": "files"
              }
            ],
            "sbg:stageInput": null
          }
        ],
        "sbg:latestRevision": 3,
        "sbg:cmdPreview": "cp /path/to/files-1.ext prefix-string-value.files-1.ext; cp /path/to/files-2.ext prefix-string-value.files-2.ext;",
        "label": "Prefixer",
        "description": "",
        "appUrl": "/u/ognjenm/tn-validation/apps/#ognjenm/tn-validation/prefixer/3",
        "sbg:contributors": [
          "ognjenm"
        ]
      },
      "sbg:x": 1016.1028051884321,
      "inputs": [
        {
          "default": "CNVkit_0_7_9",
          "id": "#Prefixer_3.prefix"
        },
        {
          "id": "#Prefixer_3.files",
          "source": [
            "#cnvkit_cnv_only.output_vcf",
            "#cnvkit_cnv_only.call_file",
            "#cnvkit_cnv_only.output_diagram_file"
          ]
        }
      ],
      "outputs": [
        {
          "id": "#Prefixer_3.renamed"
        }
      ],
      "sbg:y": 429.12832731326506
    },
    {
      "id": "#SBG_FlattenLists",
      "run": {
        "sbg:validationErrors": [],
        "class": "CommandLineTool",
        "successCodes": [],
        "sbg:sbgMaintained": false,
        "sbg:toolAuthor": "Seven Bridges",
        "sbg:id": "bix-demo/sbgtools-demo/sbg-flattenlists/4",
        "sbg:project": "bix-demo/sbgtools-demo",
        "arguments": [],
        "sbg:job": {
          "inputs": {
            "input_list": [
              {
                "class": "File",
                "path": "/path/to/input_list-1.ext",
                "size": 0,
                "secondaryFiles": []
              },
              {
                "class": "File",
                "path": "/path/to/input_list-2.ext",
                "size": 0,
                "secondaryFiles": []
              }
            ]
          },
          "allocatedResources": {
            "mem": 1000,
            "cpu": 1
          }
        },
        "sbg:modifiedOn": 1488288600,
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "cwlVersion": "sbg:draft-2",
        "sbg:cmdPreview": "echo \"Globe for *.ext extensions\"",
        "hints": [
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 1000
          },
          {
            "class": "DockerRequirement",
            "dockerPull": "ubuntu:14.04",
            "dockerImageId": ""
          }
        ],
        "sbg:categories": [
          "Other"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "mladenlSBG",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1458660825,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "mladenlSBG",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1470401111,
            "sbg:revisionNotes": "Removed inheritance of metadata on output, since now metadata is available using stage input option."
          },
          {
            "sbg:modifiedBy": "mladenlSBG",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1470401512,
            "sbg:revisionNotes": "echo command added"
          },
          {
            "sbg:modifiedBy": "mladenlSBG",
            "sbg:revision": 3,
            "sbg:modifiedOn": 1475066410,
            "sbg:revisionNotes": "Changed output globe."
          },
          {
            "sbg:modifiedBy": "mladenlSBG",
            "sbg:revision": 4,
            "sbg:modifiedOn": 1488288600,
            "sbg:revisionNotes": "Fixed to work with more than two lists."
          }
        ],
        "sbg:license": "Apache License 2.0",
        "sbg:createdBy": "mladenlSBG",
        "temporaryFailCodes": [],
        "outputs": [
          {
            "outputBinding": {
              "secondaryFiles": [
                ".bai",
                "^.bai",
                ".fai",
                "^.fai",
                ".ixd",
                "^.idx",
                ".tbi",
                "^.tbi"
              ],
              "glob": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if($job.inputs.input_list){\n    glob_list = []\n    all_list = [].concat($job.inputs.input_list)\n    i = 0\n\n    while(i<all_list.length){\n\n      if(Array.isArray(all_list[i])==true && all_list[i]){\n        if (all_list[i]){\n          j = 0\n          temp = [].concat(all_list[i])\n          while(j<temp.length){\n            if(temp[j]){\n              glob=\"*.\" + temp[j].path.split(\"/\").pop().split(\".\").pop()\n              if (!(glob_list.indexOf(glob)>-1)) {\n                glob_list = glob_list.concat(glob)\n              }\n            }\n            j++\n          }\n        }\n\n      }\n      else{\n        if(all_list[i]){\n          glob=\"*.\" + all_list[i].path.split(\"/\").pop().split(\".\").pop()\n          if (!(glob_list.indexOf(glob)>-1)) {\n              glob_list = glob_list.concat(glob)\n            }\n        }\n      }\n      i++\n    }\n\n    if(glob_list.length==1){\n      return glob_list[0]\n      }\n\n    else{ \n    glob_expression = \"{\"\n    k = 0\n    while(k<glob_list.length){\n      glob_expression = glob_expression.concat(glob_list[k])\n      if(k<glob_list.length-1){\n        glob_expression = glob_expression.concat(\",\")\n        }\n      k++\n    }\n    glob_expression = glob_expression.concat(\"}\")\n    return glob_expression\n    }\n  }\n}"
              }
            },
            "label": "Output list of files",
            "description": "Single list of files that combines all files from all inputs.",
            "id": "#output_list",
            "type": [
              "null",
              {
                "items": "File",
                "type": "array"
              }
            ]
          }
        ],
        "sbg:toolkitVersion": "1.0",
        "baseCommand": [
          "echo",
          "\"Globe",
          "for",
          {
            "engine": "#cwl-js-engine",
            "class": "Expression",
            "script": "{\n  //check if the input list is provided or not\n  if($job.inputs.input_list){\n    //create lists for all globs and new list for inputs in case of single file input, \n    //so len can be fetched\n    glob_list = []\n    all_list = [].concat($job.inputs.input_list)\n    i = 0\n\t\n    //iteration through the list\n    while(i<all_list.length){\n\t  \n      //check if the element is a list\n      if(Array.isArray(all_list[i])==true && all_list[i]){\n        //check if the list contains any elements\n        if (all_list[i]){\n          j = 0\n          temp = [].concat(all_list[i])\n          while(j<temp.length){\n            //iteration through the list, get globs that are unique and not found already\n            if(temp[j]){\n              glob=\"*.\" + temp[j].path.split(\"/\").pop().split(\".\").pop()\n              if (!(glob_list.indexOf(glob)>-1)) {\n                glob_list = glob_list.concat(glob)\n              }\n            }\n            j++\n          }\n        }\n\n      }\n      else{\n        //for single files, just get glob if it's unique\n        if(all_list[i]){\n          glob=\"*.\" + all_list[i].path.split(\"/\").pop().split(\".\").pop()\n          if (!(glob_list.indexOf(glob)>-1)) {\n              glob_list = glob_list.concat(glob)\n            }\n        }\n      }\n      i++\n    }\n\t\n    //for single globs, just return the glob\n    if(glob_list.length==1){\n      return glob_list[0]\n      }\n\n    else{ \n      //if multiple globs, the return has to be in form of {glob1,glob2,...}\n    glob_expression = \"{\"\n    k = 0\n    while(k<glob_list.length){\n      glob_expression = glob_expression.concat(glob_list[k])\n      if(k<glob_list.length-1){\n        glob_expression = glob_expression.concat(\",\")\n        }\n      k++\n    }\n    glob_expression = glob_expression.concat(\"}\")\n    return glob_expression\n    }\n  }\n}"
          },
          "extensions\""
        ],
        "sbg:modifiedBy": "mladenlSBG",
        "id": "bix-demo/sbgtools-demo/sbg-flattenlists/4",
        "sbg:revisionNotes": "Fixed to work with more than two lists.",
        "stdout": "",
        "stdin": "",
        "sbg:createdOn": 1458660825,
        "x": 1171.589925720854,
        "y": 480.1026306152368,
        "sbg:revision": 4,
        "inputs": [
          {
            "id": "#input_list",
            "sbg:category": "File inputs",
            "label": "Input list",
            "description": "List of inputs, can be any combination of lists of files and single files, it will be combined into a single list of files at the output.",
            "required": false,
            "type": [
              "null",
              {
                "items": "File",
                "type": "array"
              }
            ],
            "sbg:stageInput": "link"
          }
        ],
        "sbg:toolkit": "SBGTools",
        "sbg:latestRevision": 4,
        "sbg:image_url": null,
        "label": "SBG FlattenLists",
        "description": "Main purpose of this tool is to merge two separate file lists into a single list. If those list contain secondary files such as BAI, FAI and IDX, those files will be propagated also.",
        "sbg:contributors": [
          "mladenlSBG"
        ]
      },
      "sbg:x": 1171.589925720854,
      "inputs": [
        {
          "id": "#SBG_FlattenLists.input_list",
          "source": [
            "#Prefixer_3.renamed"
          ]
        }
      ],
      "outputs": [
        {
          "id": "#SBG_FlattenLists.output_list"
        }
      ],
      "sbg:y": 480.1026306152368
    },
    {
      "id": "#Sambamba_Index",
      "run": {
        "sbg:validationErrors": [],
        "class": "CommandLineTool",
        "sbg:links": [
          {
            "id": "http://lomereiter.github.io/sambamba/docs/sambamba-view.html",
            "label": "Homepage"
          },
          {
            "id": "https://github.com/lomereiter/sambamba",
            "label": "Source code"
          },
          {
            "id": "https://github.com/lomereiter/sambamba/wiki",
            "label": "Wiki"
          },
          {
            "id": "https://github.com/lomereiter/sambamba/releases/tag/v0.5.9",
            "label": "Download"
          },
          {
            "id": "http://lomereiter.github.io/sambamba/docs/sambamba-view.html",
            "label": "Publication"
          }
        ],
        "sbg:sbgMaintained": false,
        "sbg:toolAuthor": "Artem Tarasov",
        "sbg:id": "bix-demo/sambamba-0-5-9-demo/sambamba-index-0-5-9/8",
        "sbg:project": "bix-demo/sambamba-0-5-9-demo",
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "class": "Expression",
              "script": "{\n  if ((!(typeof $job.inputs.input_bai_file !== \"undefined\")))\n  {\n  if ($job.inputs.input_bam)\n  {\n    \n    filepath = $job.inputs.input_bam.path\n   \tfilename = filepath.split('/').slice(-1)[0]\n    \n    index_name = filename.concat(\".bai\")\n    \n    return index_name\n  }\n}\n}\n\n"
            },
            "position": 100,
            "prefix": "",
            "separate": true
          }
        ],
        "sbg:job": {
          "inputs": {
            "check_bins": false,
            "mem_mb": 2,
            "input_bam": {
              "path": "/root/dir/example.bam"
            },
            "redundancy": true,
            "cram_input": false,
            "nthreads": 4
          },
          "allocatedResources": {
            "mem": 2,
            "cpu": 4
          }
        },
        "sbg:modifiedOn": 1475064216,
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "cwlVersion": "sbg:draft-2",
        "sbg:cmdPreview": "/opt/sambamba_0.5.9/sambamba_v0.5.9 index  example.bam  example.bam.bai",
        "hints": [
          {
            "class": "DockerRequirement",
            "dockerPull": "images.sbgenomics.com/mladenlsbg/sambamba:0.5.9",
            "dockerImageId": "59e577b13d5d"
          },
          {
            "class": "sbg:CPURequirement",
            "value": {
              "engine": "#cwl-js-engine",
              "class": "Expression",
              "script": "{\n  if (!(typeof $job.inputs.input_bai_file !== \"undefined\"))\n  {\n    if ($job.inputs.nthreads)\n    \treturn $job.inputs.nthreads\n\telse\n    \treturn 8\n  }\n}"
            }
          },
          {
            "class": "sbg:MemRequirement",
            "value": {
              "engine": "#cwl-js-engine",
              "class": "Expression",
              "script": "{\n  if ($job.inputs.mem_mb) {\n    \n    return $job.inputs.mem_mb\n    \n  } else {\n    \n    return 1024\n    \n  }\n  \n}"
            }
          }
        ],
        "sbg:categories": [
          "SAM/BAM-Processing",
          "Indexing"
        ],
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1450911564,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1450911565,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1450911565,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "bix-demo",
            "sbg:revision": 3,
            "sbg:modifiedOn": 1450911566,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "mladenlSBG",
            "sbg:revision": 4,
            "sbg:modifiedOn": 1460027051,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "mladenlSBG",
            "sbg:revision": 5,
            "sbg:modifiedOn": 1462972481,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 6,
            "sbg:modifiedOn": 1468850649,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 7,
            "sbg:modifiedOn": 1470135900,
            "sbg:revisionNotes": "Avoiding redundancy"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 8,
            "sbg:modifiedOn": 1475064216,
            "sbg:revisionNotes": "Changed resource entries"
          }
        ],
        "sbg:license": "GNU General Public License v2.0 only",
        "sbg:createdBy": "bix-demo",
        "temporaryFailCodes": [],
        "outputs": [
          {
            "id": "#indexed_bam",
            "sbg:fileTypes": "BAM",
            "outputBinding": {
              "secondaryFiles": [
                "^.bai",
                ".bai"
              ],
              "glob": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if ($job.inputs.redundancy === false) {\n    \n    return ''\n    \n  } else {\n    \n    return '*.bam'\n    \n  }\n}"
              },
              "sbg:inheritMetadataFrom": "#input_bam"
            },
            "label": "Indexed BAM file",
            "description": "Bam file.",
            "type": [
              "null",
              "File"
            ]
          },
          {
            "id": "#index",
            "sbg:fileTypes": "BAI",
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#input_bam",
              "glob": "*.bai"
            },
            "label": "Index file",
            "description": "Indexed file.",
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "sbg:toolkitVersion": "0.5.9",
        "baseCommand": [
          {
            "engine": "#cwl-js-engine",
            "class": "Expression",
            "script": "{\n  if (typeof $job.inputs.input_bai_file !== \"undefined\"){\n \treturn\"echo Skipping index step because BAI file is provided on the input.\"\n  }\n  else{\n    return \"/opt/sambamba_0.5.9/sambamba_v0.5.9 index\"\n  }\n}"
          }
        ],
        "sbg:modifiedBy": "ognjenm",
        "id": "bix-demo/sambamba-0-5-9-demo/sambamba-index-0-5-9/8",
        "sbg:revisionNotes": "Changed resource entries",
        "stdout": "",
        "stdin": "",
        "sbg:createdOn": 1450911564,
        "x": 317.6666666666668,
        "y": 325.66666666666674,
        "sbg:revision": 8,
        "inputs": [
          {
            "id": "#redundancy",
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "TRUE",
            "label": "Output input BAM",
            "description": "Send the input BAM to the output thus creating redundant data.",
            "required": false,
            "type": [
              "null",
              "boolean"
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#nthreads",
            "sbg:altPrefix": "-t",
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "8",
            "required": false,
            "label": "Number of threads",
            "description": "Number of threads to use.",
            "inputBinding": {
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if (!(typeof $job.inputs.input_bai_file !== \"undefined\"))\n  {\n    if ($job.inputs.nthreads)\n    \treturn $job.inputs.nthreads\n\telse\n    \treturn 8\n  }\n}\n\n"
              },
              "sbg:cmdInclude": true,
              "prefix": "--nthreads=",
              "separate": false
            },
            "type": [
              "null",
              "int"
            ]
          },
          {
            "id": "#mem_mb",
            "sbg:category": "Execution",
            "sbg:toolDefaultValue": "1024",
            "label": "Memory in MB",
            "description": "Memory in MB.",
            "required": false,
            "type": [
              "null",
              "int"
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#input_bam",
            "sbg:category": "File input",
            "sbg:fileTypes": "BAM, CRAM",
            "required": true,
            "label": "Input file",
            "description": "BAM or CRAM file.",
            "inputBinding": {
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if ((!(typeof $job.inputs.input_bai_file !== \"undefined\")))\n  {\n    return $job.inputs.input_bam.path.split('/').slice(-1)[0]\n  }\n}"
              },
              "position": 99,
              "sbg:cmdInclude": true,
              "itemSeparator": " ",
              "separate": true
            },
            "type": [
              "File"
            ],
            "sbg:stageInput": "link"
          },
          {
            "id": "#input_bai_file",
            "sbg:category": "File input",
            "sbg:fileTypes": "BAI",
            "label": "Input BAI(BAM index) file",
            "description": "Input BAI(BAM index) file.",
            "required": false,
            "type": [
              "null",
              "File"
            ],
            "sbg:stageInput": "link"
          },
          {
            "id": "#cram_input",
            "sbg:category": "Execution",
            "inputBinding": {
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if ((!(typeof $job.inputs.input_bai_file !== \"undefined\")) && ($job.inputs.cram_input === true))\n  {\n    return \"--cram-input\" \n  }\n}"
              },
              "sbg:cmdInclude": true,
              "itemSeparator": null,
              "separate": true
            },
            "label": "CRAM input",
            "description": "Specify that input is in CRAM format.",
            "required": false,
            "type": [
              "null",
              "boolean"
            ]
          },
          {
            "id": "#check_bins",
            "sbg:altPrefix": "c",
            "sbg:category": "Execution",
            "required": false,
            "label": "Check bins",
            "description": "Check that bins are set correctly.",
            "inputBinding": {
              "valueFrom": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  if ((!(typeof $job.inputs.input_bai_file !== \"undefined\")) && ($job.inputs.check_bins === true))\n  {\n    return \"--check-bins\" \n  }\n}"
              },
              "sbg:cmdInclude": true,
              "separate": true
            },
            "type": [
              "null",
              "boolean"
            ]
          }
        ],
        "sbg:toolkit": "Sambamba",
        "sbg:latestRevision": 8,
        "successCodes": [],
        "sbg:image_url": null,
        "label": "Sambamba Index",
        "description": "Sambamba Index creates an index for a BAM or CRAM file.",
        "appUrl": "/u/bix-demo/sambamba-0-5-9-demo/apps/#bix-demo/sambamba-0-5-9-demo/sambamba-index-0-5-9/8",
        "sbg:contributors": [
          "ognjenm",
          "mladenlSBG",
          "bix-demo"
        ]
      },
      "sbg:x": 317.6666666666668,
      "scatter": "#Sambamba_Index.input_bam",
      "inputs": [
        {
          "default": true,
          "id": "#Sambamba_Index.redundancy"
        },
        {
          "default": 8,
          "id": "#Sambamba_Index.nthreads"
        },
        {
          "default": 14000,
          "id": "#Sambamba_Index.mem_mb"
        },
        {
          "id": "#Sambamba_Index.input_bam",
          "source": [
            "#normal_bam"
          ]
        },
        {
          "id": "#Sambamba_Index.input_bai_file"
        },
        {
          "id": "#Sambamba_Index.cram_input"
        },
        {
          "id": "#Sambamba_Index.check_bins"
        }
      ],
      "outputs": [
        {
          "id": "#Sambamba_Index.indexed_bam"
        },
        {
          "id": "#Sambamba_Index.index"
        }
      ],
      "sbg:y": 325.66666666666674
    },
    {
      "id": "#BMS_Rename_App",
      "run": {
        "sbg:validationErrors": [],
        "class": "CommandLineTool",
        "successCodes": [],
        "sbg:sbgMaintained": false,
        "sbg:project": "ognjenm/bms-test-run",
        "arguments": [
          {
            "valueFrom": {
              "engine": "#cwl-js-engine",
              "class": "Expression",
              "script": "{\n  \n  normal = [].concat($job.inputs.normal_file)[0].path.split('/').pop().split('.')[0]\n  tumor = [].concat($job.inputs.tumor_file)[0].path.split('/').pop().split('.')[0]\n  \n return  normal + '_' + tumor + '_' + $job.inputs.tool_string\n  \n}"
            },
            "position": 10,
            "separate": true
          }
        ],
        "sbg:job": {
          "inputs": {
            "tumor_file": {
              "class": "File",
              "path": "/path/to/tumor_file.ext",
              "size": 0,
              "secondaryFiles": []
            },
            "normal_file": {
              "class": "File",
              "path": "/path/to/normal_file.ext",
              "size": 0,
              "secondaryFiles": []
            },
            "tool_string": "tool_string-string-value",
            "input_file": {
              "class": "File",
              "path": "/path/to/input_file.ext",
              "size": 0,
              "secondaryFiles": []
            }
          },
          "allocatedResources": {
            "mem": 1000,
            "cpu": 1
          }
        },
        "sbg:modifiedOn": 1489050950,
        "requirements": [
          {
            "class": "ExpressionEngineRequirement",
            "id": "#cwl-js-engine",
            "requirements": [
              {
                "class": "DockerRequirement",
                "dockerPull": "rabix/js-engine"
              }
            ]
          }
        ],
        "cwlVersion": "sbg:draft-2",
        "hints": [
          {
            "class": "sbg:CPURequirement",
            "value": 1
          },
          {
            "class": "sbg:MemRequirement",
            "value": 1000
          },
          {
            "class": "DockerRequirement",
            "dockerPull": "ubuntu:14.04",
            "dockerImageId": ""
          }
        ],
        "sbg:id": "ognjenm/bms-test-run/bms-rename-app/4",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1476442816,
            "sbg:revisionNotes": null
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1476443341,
            "sbg:revisionNotes": "Initial"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1476445543,
            "sbg:revisionNotes": "Changed input file type to file"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 3,
            "sbg:modifiedOn": 1488981844,
            "sbg:revisionNotes": "Protected against array at inputs"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 4,
            "sbg:modifiedOn": 1489050950,
            "sbg:revisionNotes": "Updated GLOB too"
          }
        ],
        "sbg:image_url": null,
        "outputs": [
          {
            "outputBinding": {
              "sbg:inheritMetadataFrom": "#tumor_file",
              "glob": {
                "engine": "#cwl-js-engine",
                "class": "Expression",
                "script": "{\n  \n  normal = [].concat($job.inputs.normal_file)[0].path.split('/').pop().split('.')[0]\n  tumor = [].concat($job.inputs.tumor_file)[0].path.split('/').pop().split('.')[0]\n  \n return  normal + '_' + tumor + '_' + $job.inputs.tool_string\n  \n}"
              }
            },
            "label": "Output file",
            "description": "Renamed output file.",
            "id": "#output_file",
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "temporaryFailCodes": [],
        "sbg:createdBy": "ognjenm",
        "baseCommand": [
          "cp"
        ],
        "sbg:modifiedBy": "ognjenm",
        "id": "ognjenm/bms-test-run/bms-rename-app/4",
        "sbg:revisionNotes": "Updated GLOB too",
        "stdout": "",
        "stdin": "",
        "sbg:createdOn": 1476442816,
        "x": 1461.8720390796757,
        "y": 384.3590247334831,
        "sbg:revision": 4,
        "inputs": [
          {
            "id": "#tumor_file",
            "sbg:category": "File Input",
            "label": "Tumor file",
            "description": "Tumor file.",
            "required": true,
            "type": [
              "File"
            ]
          },
          {
            "id": "#tool_string",
            "sbg:category": "Execution",
            "label": "Tool string",
            "description": "Tool string in desired format with extension.",
            "required": false,
            "type": [
              "null",
              "string"
            ]
          },
          {
            "id": "#normal_file",
            "sbg:category": "File Input",
            "label": "Normal file",
            "description": "Normal file.",
            "required": true,
            "type": [
              "File"
            ]
          },
          {
            "id": "#input_file",
            "sbg:category": "File Input",
            "inputBinding": {
              "position": 3,
              "sbg:cmdInclude": true,
              "separate": true
            },
            "label": "Input file",
            "description": "Input file.",
            "required": false,
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "sbg:latestRevision": 4,
        "sbg:cmdPreview": "cp  normal_file_tumor_file_tool_string-string-value",
        "label": "BMS Rename App",
        "description": "",
        "appUrl": "/u/ognjenm/bms-test-run/apps/#ognjenm/bms-test-run/bms-rename-app/4",
        "sbg:contributors": [
          "ognjenm"
        ]
      },
      "sbg:x": 1461.8720390796757,
      "inputs": [
        {
          "id": "#BMS_Rename_App.tumor_file",
          "source": [
            "#tumor_bam"
          ]
        },
        {
          "default": "cnv.tar",
          "id": "#BMS_Rename_App.tool_string"
        },
        {
          "id": "#BMS_Rename_App.normal_file",
          "source": [
            "#normal_bam"
          ]
        },
        {
          "id": "#BMS_Rename_App.input_file",
          "source": [
            "#SBG_Compressor.output_archives"
          ]
        }
      ],
      "outputs": [
        {
          "id": "#BMS_Rename_App.output_file"
        }
      ],
      "sbg:y": 384.3590247334831
    },
    {
      "id": "#cnvkit_cnv_only",
      "run": {
        "sbg:validationErrors": [],
        "class": "Workflow",
        "steps": [
          {
            "id": "#cnvkit_fix_1",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "successCodes": [],
              "sbg:sbgMaintained": false,
              "sbg:project": "milan.domazet/cnvkit-test",
              "arguments": [
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  var fileName=$job.inputs.target_coverage_file.path.replace(/^.*[/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  return fileName+\".fix.cnr\"\n}"
                  },
                  "position": 5,
                  "prefix": "--output",
                  "separate": true
                }
              ],
              "sbg:job": {
                "inputs": {
                  "target_coverage_file": {
                    "class": "File",
                    "path": "/path/to/target_coverage_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "no_gc": true,
                  "reference_coverage_file": {
                    "class": "File",
                    "path": "/path/to/reference_coverage_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "no_edge": true,
                  "antitarget_coverage_file": {
                    "class": "File",
                    "path": "/path/to/antitarget_coverage_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  }
                },
                "allocatedResources": {
                  "mem": 1024,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1459852614,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "hints": [
                {
                  "class": "DockerRequirement",
                  "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
                  "dockerImageId": ""
                }
              ],
              "sbg:id": "milan.domazet/cnvkit-test/cnvkit-fix/2",
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1459850345
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1459790612
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1459852614
                }
              ],
              "sbg:image_url": null,
              "outputs": [
                {
                  "id": "#fix_output",
                  "fileTypes": "CNR",
                  "outputBinding": {
                    "sbg:inheritMetadataFrom": "#target_coverage_file",
                    "glob": "*.cnr"
                  },
                  "label": "Fix output file.",
                  "description": "Fix output (.CNR) file.",
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "temporaryFailCodes": [],
              "sbg:createdBy": "milan.domazet",
              "baseCommand": [
                "cnvkit.py",
                "fix"
              ],
              "sbg:modifiedBy": "milan.domazet",
              "id": "milan.domazet/cnvkit-test/cnvkit-fix/2",
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1459790612,
              "x": 955.0000525437873,
              "y": 509.00002800501335,
              "sbg:revision": 2,
              "inputs": [
                {
                  "id": "#target_coverage_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "CNN",
                  "required": true,
                  "label": "Target coverage file",
                  "description": "Target coverage file.",
                  "inputBinding": {
                    "position": 0,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                },
                {
                  "id": "#reference_coverage_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "CNN",
                  "required": true,
                  "label": "Reference coverage file",
                  "description": "Reference coverage file.",
                  "inputBinding": {
                    "position": 2,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                },
                {
                  "id": "#no_gc",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "No GC",
                  "description": "Skip GC correction.",
                  "inputBinding": {
                    "prefix": "--no-gc",
                    "position": 3,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#no_edge",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "No edge",
                  "description": "Skip edge-effect correction.",
                  "inputBinding": {
                    "prefix": "--no-edge",
                    "position": 4,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#antitarget_coverage_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "CNN",
                  "required": true,
                  "label": "Antitarget coverage file",
                  "description": "Antitarget coverage file.",
                  "inputBinding": {
                    "position": 1,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                }
              ],
              "sbg:latestRevision": 2,
              "sbg:cmdPreview": "cnvkit.py fix  /path/to/target_coverage_file.ext  /path/to/antitarget_coverage_file.ext  /path/to/reference_coverage_file.ext --output target_coverage_file.fix.cnr",
              "label": "cnvkit-fix",
              "description": "",
              "sbg:contributors": [
                "milan.domazet"
              ]
            },
            "sbg:x": 955.0000525437873,
            "inputs": [
              {
                "id": "#cnvkit_fix_1.target_coverage_file",
                "source": [
                  "#cnkit_coverage_1.coverage_file"
                ]
              },
              {
                "id": "#cnvkit_fix_1.reference_coverage_file",
                "source": [
                  "#cnvkit_reference.reference_output"
                ]
              },
              {
                "id": "#cnvkit_fix_1.no_gc"
              },
              {
                "id": "#cnvkit_fix_1.no_edge"
              },
              {
                "id": "#cnvkit_fix_1.antitarget_coverage_file",
                "source": [
                  "#cnkit_coverage.coverage_file"
                ]
              }
            ],
            "outputs": [
              {
                "id": "#cnvkit_fix_1.fix_output"
              }
            ],
            "sbg:y": 509.00002800501335
          },
          {
            "id": "#cnvkit_segment",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "successCodes": [],
              "sbg:sbgMaintained": false,
              "sbg:project": "milan.domazet/cnvkit-test",
              "arguments": [
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  if($job.inputs.dataframe){\n    var fileName=$job.inputs.fix_file.path.replace(/^.*[/]/, '');\n\tfileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n    return fileName+\".dataframe.txt\"\n  }\n  else return \"\"\n}"
                  },
                  "position": 6,
                  "separate": true
                },
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  var fileName=$job.inputs.fix_file.path.replace(/^.*[/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  return fileName+\".segment.cns\"\n}"
                  },
                  "position": 7,
                  "prefix": "--output",
                  "separate": true
                }
              ],
              "sbg:job": {
                "inputs": {
                  "vcf_file": {
                    "class": "File",
                    "path": "/path/to/vcf_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "significance_threshold": 6.73510178906297,
                  "method": "cbs",
                  "drop_low_coverage": true,
                  "dataframe": true,
                  "drop_outliers": 7,
                  "fix_file": {
                    "class": "File",
                    "path": "/path/to/fix_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  }
                },
                "allocatedResources": {
                  "mem": 1024,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1459852667,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "hints": [
                {
                  "class": "DockerRequirement",
                  "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
                  "dockerImageId": ""
                }
              ],
              "sbg:id": "milan.domazet/cnvkit-test/cnvkit-segment/3",
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1459851421
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1459852559
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1459852107
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 3,
                  "sbg:modifiedOn": 1459852667
                }
              ],
              "sbg:image_url": null,
              "outputs": [
                {
                  "id": "#segment_output",
                  "fileTypes": "CNS",
                  "outputBinding": {
                    "sbg:inheritMetadataFrom": "#fix_file",
                    "loadContents": false,
                    "glob": "*.cns"
                  },
                  "label": "Segment output file",
                  "description": "Segment output (.CNS) file.",
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "temporaryFailCodes": [],
              "sbg:createdBy": "milan.domazet",
              "baseCommand": [
                "cnvkit.py",
                "segment"
              ],
              "sbg:modifiedBy": "milan.domazet",
              "id": "milan.domazet/cnvkit-test/cnvkit-segment/3",
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1459851421,
              "x": 1111.0000611268563,
              "y": 516.4615669617289,
              "sbg:revision": 3,
              "inputs": [
                {
                  "id": "#vcf_file",
                  "sbg:altPrefix": "-v",
                  "sbg:category": "Optional arguments",
                  "sbg:fileTypes": "VCF",
                  "required": false,
                  "label": "VCF file",
                  "description": "VCF file containing variants for segmentation by allele frequencies.",
                  "inputBinding": {
                    "prefix": "--vcf",
                    "position": 3,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "File"
                  ]
                },
                {
                  "id": "#significance_threshold",
                  "sbg:altPrefix": "-t",
                  "sbg:category": "Optional arguments",
                  "label": "Significance threshold",
                  "description": "Significance threshold (p-value or FDR, depending on method) to accept breakpoints during segmentation.",
                  "inputBinding": {
                    "prefix": "--threshold",
                    "position": 2,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "float"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#method",
                  "sbg:altPrefix": "-m",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "cbs",
                  "label": "Segmentation method",
                  "description": "Segmentation method (CBS, HaarSeg, or Fused Lasso).",
                  "inputBinding": {
                    "prefix": "--method",
                    "position": 1,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    {
                      "type": "enum",
                      "name": "method",
                      "symbols": [
                        "cbs",
                        "haar",
                        "flasso"
                      ]
                    }
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#fix_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "CNR",
                  "required": true,
                  "label": "Bin-level log2 ratios",
                  "description": "Bin-level log2 ratios (.cnr file), as produced by 'fix'.",
                  "inputBinding": {
                    "position": 0,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                },
                {
                  "id": "#drop_outliers",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "10",
                  "label": "Drop outliers",
                  "description": "Drop outlier bins more than this many multiples of the 95th quantile away from the average within a rolling window. Set to 0 for no outlier filtering.",
                  "inputBinding": {
                    "prefix": "--drop-outliers",
                    "position": 5,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "int"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#drop_low_coverage",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "Drop low coverage",
                  "description": "Drop very-low-coverage bins before segmentation to avoid false-positive deletions in poor-quality tumor samples.",
                  "inputBinding": {
                    "prefix": "--drop-low-coverage",
                    "position": 4,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#dataframe",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "Save dataframe",
                  "description": "Save the raw R dataframe emitted by CBS or Fused Lasso. (Useful for debugging.)",
                  "sbg:stageInput": null,
                  "type": [
                    "null",
                    "boolean"
                  ]
                }
              ],
              "sbg:latestRevision": 3,
              "sbg:cmdPreview": "cnvkit.py segment  /path/to/fix_file.ext  fix_file.dataframe.txt --output fix_file.segment.cns",
              "label": "cnvkit-segment",
              "description": "",
              "sbg:contributors": [
                "milan.domazet"
              ]
            },
            "sbg:x": 1111.0000611268563,
            "inputs": [
              {
                "id": "#cnvkit_segment.vcf_file"
              },
              {
                "id": "#cnvkit_segment.significance_threshold",
                "source": [
                  "#significance_threshold"
                ]
              },
              {
                "id": "#cnvkit_segment.method",
                "source": [
                  "#method"
                ]
              },
              {
                "id": "#cnvkit_segment.fix_file",
                "source": [
                  "#cnvkit_fix_1.fix_output"
                ]
              },
              {
                "id": "#cnvkit_segment.drop_outliers",
                "source": [
                  "#drop_outliers"
                ]
              },
              {
                "id": "#cnvkit_segment.drop_low_coverage",
                "source": [
                  "#drop_low_coverage"
                ]
              },
              {
                "id": "#cnvkit_segment.dataframe",
                "source": [
                  "#dataframe"
                ]
              }
            ],
            "outputs": [
              {
                "id": "#cnvkit_segment.segment_output"
              }
            ],
            "sbg:y": 516.4615669617289
          },
          {
            "id": "#cnvkit_export_vcf",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "successCodes": [],
              "sbg:sbgMaintained": false,
              "sbg:project": "milan.domazet/cnvkit-test",
              "arguments": [
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  var fileName=$job.inputs.segment_file.path.replace(/^.*[/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  return fileName+\".export.vcf\"\n}"
                  },
                  "position": 6,
                  "prefix": "--output",
                  "separate": true
                }
              ],
              "sbg:job": {
                "inputs": {
                  "sample_label": "sample_label-string-value",
                  "gender": "Male",
                  "segment_file": {
                    "class": "File",
                    "path": "/path/to/segment_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "male_reference": true,
                  "ploidy": 8
                },
                "allocatedResources": {
                  "mem": 1024,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1463484070,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "hints": [
                {
                  "class": "DockerRequirement",
                  "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
                  "dockerImageId": ""
                }
              ],
              "sbg:id": "milan.domazet/cnvkit-test/cnvkit-export-vcf/2",
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1463483625
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1463484050
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1463484070
                }
              ],
              "sbg:image_url": null,
              "outputs": [
                {
                  "id": "#output_vcf",
                  "fileTypes": "VCF",
                  "outputBinding": {
                    "glob": "*.vcf"
                  },
                  "label": "Exported VCF file",
                  "description": "Exported VCF file.",
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "temporaryFailCodes": [],
              "sbg:createdBy": "milan.domazet",
              "baseCommand": [
                "cnvkit.py",
                "export",
                "vcf"
              ],
              "sbg:modifiedBy": "milan.domazet",
              "id": "milan.domazet/cnvkit-test/cnvkit-export-vcf/2",
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1463483625,
              "x": 1409.4736842105262,
              "y": 361.5789473684211,
              "sbg:revision": 2,
              "inputs": [
                {
                  "id": "#segment_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "CNS",
                  "required": true,
                  "label": "Segment CNS file",
                  "description": "Segmented copy ratio data file (*.cns), the output of the 'segment' or 'call' sub-commands.",
                  "inputBinding": {
                    "position": 1,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                },
                {
                  "id": "#sample_label",
                  "sbg:altPrefix": "-i",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "Use the sample ID, taken from the file name.",
                  "label": "Sample label",
                  "description": "Sample name to write in the genotype field of the output VCF file.",
                  "inputBinding": {
                    "prefix": "--sample-id",
                    "position": 2,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "string"
                  ]
                },
                {
                  "id": "#ploidy",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "2",
                  "label": "Ploidy of the sample cells",
                  "description": "Ploidy of the sample cells.",
                  "inputBinding": {
                    "prefix": "--ploidy",
                    "position": 3,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "int"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#male_reference",
                  "sbg:altPrefix": "-y",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "Male reference",
                  "description": "Was a male reference used? If so, expect half ploidy on chrX and chrY; otherwise, only chrY has half ploidy. In CNVkit, if a male reference was used, the \"neutral\" copy number (ploidy) of chrX is 1; chrY is haploid for either gender reference.",
                  "inputBinding": {
                    "prefix": "--male-reference",
                    "position": 5,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#gender",
                  "sbg:altPrefix": "-g",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "Otherwise guessed from chrX copy number.",
                  "label": "Sample's gender",
                  "description": "Specify the sample's gender as male or female.",
                  "inputBinding": {
                    "prefix": "--gender",
                    "position": 4,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    {
                      "type": "enum",
                      "name": "gender",
                      "symbols": [
                        "Male",
                        "Female"
                      ]
                    }
                  ],
                  "sbg:stageInput": null
                }
              ],
              "sbg:latestRevision": 2,
              "sbg:cmdPreview": "cnvkit.py export vcf  /path/to/segment_file.ext --output segment_file.export.vcf",
              "label": "cnvkit-export-vcf",
              "description": "",
              "sbg:contributors": [
                "milan.domazet"
              ]
            },
            "sbg:x": 1409.4736842105262,
            "inputs": [
              {
                "id": "#cnvkit_export_vcf.segment_file",
                "source": [
                  "#cnvkit_call.call_file"
                ]
              },
              {
                "id": "#cnvkit_export_vcf.sample_label"
              },
              {
                "id": "#cnvkit_export_vcf.ploidy"
              },
              {
                "id": "#cnvkit_export_vcf.male_reference"
              },
              {
                "id": "#cnvkit_export_vcf.gender"
              }
            ],
            "outputs": [
              {
                "id": "#cnvkit_export_vcf.output_vcf"
              }
            ],
            "sbg:y": 361.5789473684211
          },
          {
            "id": "#cnvkit_diagram",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "successCodes": [],
              "sbg:sbgMaintained": false,
              "sbg:project": "milan.domazet/cnvkit-test",
              "arguments": [
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  if ($job.inputs.input_file){\n  \tvar fileName=$job.inputs.input_file.path.replace(/^.*[/]/, '');\n  \tfileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  \treturn fileName+\".diagram.pdf\"\n  } else {\n    var fileName=$job.inputs.segment_file.path.replace(/^.*[/]/, '');\n  \tfileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  \treturn fileName+\".diagram.pdf\"\n  }\n}"
                  },
                  "position": 6,
                  "prefix": "--output",
                  "separate": true
                }
              ],
              "sbg:job": {
                "inputs": {
                  "min_probes": 2,
                  "threshold": 6.998104190257,
                  "segment_file": {
                    "class": "File",
                    "path": "/path/to/segment_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "male_reference": true
                },
                "allocatedResources": {
                  "mem": 1000,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1477316270,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "hints": [
                {
                  "class": "DockerRequirement",
                  "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
                  "dockerImageId": ""
                },
                {
                  "class": "sbg:CPURequirement",
                  "value": 1
                },
                {
                  "class": "sbg:MemRequirement",
                  "value": 1000
                }
              ],
              "sbg:id": "milan.domazet/cnvkit-test/cnvkit-diagram/4",
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1463483106,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1463483511,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1463484102,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "ognjenm",
                  "sbg:revision": 3,
                  "sbg:modifiedOn": 1477306706,
                  "sbg:revisionNotes": "Removed required from input file"
                },
                {
                  "sbg:modifiedBy": "ognjenm",
                  "sbg:revision": 4,
                  "sbg:modifiedOn": 1477316270,
                  "sbg:revisionNotes": "Updated output file name"
                }
              ],
              "sbg:image_url": null,
              "outputs": [
                {
                  "id": "#output_diagram_file",
                  "sbg:fileTypes": "PDF",
                  "outputBinding": {
                    "glob": "*.pdf"
                  },
                  "label": "Output diagram PDF file",
                  "description": "Output diagram PDF file.",
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "temporaryFailCodes": [],
              "sbg:createdBy": "milan.domazet",
              "baseCommand": [
                "cnvkit.py",
                "diagram"
              ],
              "sbg:modifiedBy": "ognjenm",
              "id": "milan.domazet/cnvkit-test/cnvkit-diagram/4",
              "sbg:revisionNotes": "Updated output file name",
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1463483106,
              "x": 1339.5143559261996,
              "y": 689.5141857856152,
              "sbg:revision": 4,
              "inputs": [
                {
                  "id": "#threshold",
                  "sbg:altPrefix": "-t",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "0.5",
                  "label": "Copy number threshold",
                  "description": "Copy number change threshold to label genes.",
                  "inputBinding": {
                    "prefix": "--threshold",
                    "position": 3,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "float"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#segment_file",
                  "sbg:altPrefix": "-s",
                  "sbg:category": "Optional arguments",
                  "sbg:fileTypes": "CNS",
                  "required": false,
                  "label": "Segment CNS file",
                  "description": "Segmentation calls (.cns), the output of the 'segment' command.",
                  "inputBinding": {
                    "prefix": "--segment",
                    "position": 2,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "File"
                  ]
                },
                {
                  "id": "#min_probes",
                  "sbg:altPrefix": "-m",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "3",
                  "label": "Minimum number of covered probes",
                  "description": "Minimum number of covered probes to label a gene.",
                  "inputBinding": {
                    "prefix": "--min-probes",
                    "position": 4,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "int"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "sbg:stageInput": null,
                  "id": "#male_reference",
                  "sbg:altPrefix": "-y",
                  "sbg:category": "Optional arguments",
                  "sbg:includeInPorts": true,
                  "required": false,
                  "label": "Male reference",
                  "sbg:toolDefaultValue": "False",
                  "inputBinding": {
                    "prefix": "--male-reference",
                    "position": 5,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "description": "Assume inputs are already corrected against a male reference (i.e. female samples will have +1 log-CNR of chrX; otherwise male samples would have -1 chrX)."
                },
                {
                  "id": "#input_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "CNR",
                  "required": false,
                  "label": "Input CNR file (from CNV-kit Fix)",
                  "description": "Processed coverage data file (*.cnr), the output of the 'fix' sub-command.",
                  "inputBinding": {
                    "position": 1,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "sbg:latestRevision": 4,
              "sbg:cmdPreview": "cnvkit.py diagram --output segment_file.diagram.pdf",
              "label": "cnvkit-diagram",
              "description": "",
              "sbg:contributors": [
                "milan.domazet",
                "ognjenm"
              ]
            },
            "sbg:x": 1339.5143559261996,
            "inputs": [
              {
                "id": "#cnvkit_diagram.threshold"
              },
              {
                "id": "#cnvkit_diagram.segment_file",
                "source": [
                  "#cnvkit_segment.segment_output"
                ]
              },
              {
                "id": "#cnvkit_diagram.min_probes"
              },
              {
                "id": "#cnvkit_diagram.male_reference",
                "source": [
                  "#male_reference"
                ]
              },
              {
                "id": "#cnvkit_diagram.input_file",
                "source": [
                  "#cnvkit_fix_1.fix_output"
                ]
              }
            ],
            "outputs": [
              {
                "id": "#cnvkit_diagram.output_diagram_file"
              }
            ],
            "sbg:y": 689.5141857856152
          },
          {
            "id": "#cnkit_coverage_1",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "successCodes": [],
              "sbg:sbgMaintained": false,
              "sbg:project": "milan.domazet/cnvkit-test",
              "arguments": [
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  var fileName=$job.inputs.bam_file.path.replace(/^.*[\\\\\\/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  if(($job.inputs.interval_file.path).indexOf(\"antitarget\") > -1){\n   return fileName+\".antitarget.coverage.cnn\"\n  }\n  else return fileName+\".target.coverage.cnn\"\n}"
                  },
                  "position": 4,
                  "prefix": "--output",
                  "separate": true
                }
              ],
              "sbg:job": {
                "inputs": {
                  "count": true,
                  "bam_file": {
                    "class": "File",
                    "path": "/path/to/bam_file.ext",
                    "size": 0,
                    "secondaryFiles": [
                      {
                        "path": ".bai"
                      }
                    ]
                  },
                  "interval_file": {
                    "class": "File",
                    "path": "/path/to/interval_file.antitarget.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "min_mapq": 8
                },
                "allocatedResources": {
                  "mem": 1000,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1476811242,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "hints": [
                {
                  "class": "DockerRequirement",
                  "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
                  "dockerImageId": ""
                },
                {
                  "class": "sbg:CPURequirement",
                  "value": 1
                },
                {
                  "class": "sbg:MemRequirement",
                  "value": 1000
                }
              ],
              "sbg:id": "milan.domazet/cnvkit-test/cnkit-coverage/5",
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1459787673,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1459787936,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1459788026,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 3,
                  "sbg:modifiedOn": 1459788105,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 4,
                  "sbg:modifiedOn": 1460114335,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 5,
                  "sbg:modifiedOn": 1476811242,
                  "sbg:revisionNotes": "Added .bai as secondary for BAM file."
                }
              ],
              "sbg:image_url": null,
              "outputs": [
                {
                  "id": "#coverage_file",
                  "sbg:fileTypes": "CNN",
                  "outputBinding": {
                    "sbg:inheritMetadataFrom": "#bam_file",
                    "glob": "*.cnn"
                  },
                  "label": "Coverage output file",
                  "description": "Coverage output file.",
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "temporaryFailCodes": [],
              "sbg:createdBy": "milan.domazet",
              "baseCommand": [
                "cnvkit.py",
                "coverage"
              ],
              "sbg:modifiedBy": "milan.domazet",
              "id": "milan.domazet/cnvkit-test/cnkit-coverage/5",
              "sbg:revisionNotes": "Added .bai as secondary for BAM file.",
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1459787673,
              "x": 499,
              "y": 627,
              "sbg:revision": 5,
              "inputs": [
                {
                  "id": "#min_mapq",
                  "sbg:altPrefix": "-q",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "0",
                  "label": "Minimum mapping quality score",
                  "description": "Minimum mapping quality score (phred scale 0-60) to count a read for coverage depth.",
                  "inputBinding": {
                    "prefix": "--min-mapq",
                    "position": 3,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "int"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#interval_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "BED,LIST",
                  "required": true,
                  "label": "Interval file",
                  "description": "Intervals.",
                  "inputBinding": {
                    "position": 1,
                    "sbg:cmdInclude": true,
                    "loadContents": false,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                },
                {
                  "id": "#count",
                  "sbg:altPrefix": "-c",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "Count read midpoints",
                  "description": "Get read depths by counting read midpoints within each bin. (An alternative algorithm).",
                  "inputBinding": {
                    "prefix": "--count",
                    "position": 2,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#bam_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "BAM",
                  "required": true,
                  "label": "BAM file input",
                  "description": "Mapped sequence reads.",
                  "inputBinding": {
                    "secondaryFiles": [
                      ".bai"
                    ],
                    "position": 0,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                }
              ],
              "sbg:latestRevision": 5,
              "sbg:cmdPreview": "cnvkit.py coverage  /path/to/bam_file.ext  /path/to/interval_file.antitarget.ext --output bam_file.antitarget.coverage.cnn",
              "label": "cnkit-coverage",
              "description": "",
              "sbg:contributors": [
                "milan.domazet"
              ]
            },
            "sbg:x": 499,
            "inputs": [
              {
                "id": "#cnkit_coverage_1.min_mapq"
              },
              {
                "id": "#cnkit_coverage_1.interval_file",
                "source": [
                  "#target_bed"
                ]
              },
              {
                "id": "#cnkit_coverage_1.count"
              },
              {
                "id": "#cnkit_coverage_1.bam_file",
                "source": [
                  "#tumor_bam"
                ]
              }
            ],
            "outputs": [
              {
                "id": "#cnkit_coverage_1.coverage_file"
              }
            ],
            "sbg:y": 627
          },
          {
            "id": "#cnkit_coverage",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "successCodes": [],
              "sbg:sbgMaintained": false,
              "sbg:project": "milan.domazet/cnvkit-test",
              "arguments": [
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  var fileName=$job.inputs.bam_file.path.replace(/^.*[\\\\\\/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  if(($job.inputs.interval_file.path).indexOf(\"antitarget\") > -1){\n   return fileName+\".antitarget.coverage.cnn\"\n  }\n  else return fileName+\".target.coverage.cnn\"\n}"
                  },
                  "position": 4,
                  "prefix": "--output",
                  "separate": true
                }
              ],
              "sbg:job": {
                "inputs": {
                  "count": true,
                  "bam_file": {
                    "class": "File",
                    "path": "/path/to/bam_file.ext",
                    "size": 0,
                    "secondaryFiles": [
                      {
                        "path": ".bai"
                      }
                    ]
                  },
                  "interval_file": {
                    "class": "File",
                    "path": "/path/to/interval_file.antitarget.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "min_mapq": 8
                },
                "allocatedResources": {
                  "mem": 1000,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1476811242,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "hints": [
                {
                  "class": "DockerRequirement",
                  "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
                  "dockerImageId": ""
                },
                {
                  "class": "sbg:CPURequirement",
                  "value": 1
                },
                {
                  "class": "sbg:MemRequirement",
                  "value": 1000
                }
              ],
              "sbg:id": "milan.domazet/cnvkit-test/cnkit-coverage/5",
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1459787673,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1459787936,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1459788026,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 3,
                  "sbg:modifiedOn": 1459788105,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 4,
                  "sbg:modifiedOn": 1460114335,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 5,
                  "sbg:modifiedOn": 1476811242,
                  "sbg:revisionNotes": "Added .bai as secondary for BAM file."
                }
              ],
              "sbg:image_url": null,
              "outputs": [
                {
                  "id": "#coverage_file",
                  "sbg:fileTypes": "CNN",
                  "outputBinding": {
                    "sbg:inheritMetadataFrom": "#bam_file",
                    "glob": "*.cnn"
                  },
                  "label": "Coverage output file",
                  "description": "Coverage output file.",
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "temporaryFailCodes": [],
              "sbg:createdBy": "milan.domazet",
              "baseCommand": [
                "cnvkit.py",
                "coverage"
              ],
              "sbg:modifiedBy": "milan.domazet",
              "id": "milan.domazet/cnvkit-test/cnkit-coverage/5",
              "sbg:revisionNotes": "Added .bai as secondary for BAM file.",
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1459787673,
              "x": 643,
              "y": 426.99999999999994,
              "sbg:revision": 5,
              "inputs": [
                {
                  "id": "#min_mapq",
                  "sbg:altPrefix": "-q",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "0",
                  "label": "Minimum mapping quality score",
                  "description": "Minimum mapping quality score (phred scale 0-60) to count a read for coverage depth.",
                  "inputBinding": {
                    "prefix": "--min-mapq",
                    "position": 3,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "int"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#interval_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "BED,LIST",
                  "required": true,
                  "label": "Interval file",
                  "description": "Intervals.",
                  "inputBinding": {
                    "position": 1,
                    "sbg:cmdInclude": true,
                    "loadContents": false,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                },
                {
                  "id": "#count",
                  "sbg:altPrefix": "-c",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "Count read midpoints",
                  "description": "Get read depths by counting read midpoints within each bin. (An alternative algorithm).",
                  "inputBinding": {
                    "prefix": "--count",
                    "position": 2,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#bam_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "BAM",
                  "required": true,
                  "label": "BAM file input",
                  "description": "Mapped sequence reads.",
                  "inputBinding": {
                    "secondaryFiles": [
                      ".bai"
                    ],
                    "position": 0,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                }
              ],
              "sbg:latestRevision": 5,
              "sbg:cmdPreview": "cnvkit.py coverage  /path/to/bam_file.ext  /path/to/interval_file.antitarget.ext --output bam_file.antitarget.coverage.cnn",
              "label": "cnkit-coverage",
              "description": "",
              "sbg:contributors": [
                "milan.domazet"
              ]
            },
            "sbg:x": 643,
            "inputs": [
              {
                "id": "#cnkit_coverage.min_mapq"
              },
              {
                "id": "#cnkit_coverage.interval_file",
                "source": [
                  "#antitarget_bed"
                ]
              },
              {
                "id": "#cnkit_coverage.count"
              },
              {
                "id": "#cnkit_coverage.bam_file",
                "source": [
                  "#tumor_bam"
                ]
              }
            ],
            "outputs": [
              {
                "id": "#cnkit_coverage.coverage_file"
              }
            ],
            "sbg:y": 426.99999999999994
          },
          {
            "id": "#cnvkit_reference",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "successCodes": [],
              "sbg:sbgMaintained": false,
              "sbg:project": "milan.domazet/cnvkit-test",
              "arguments": [
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  return \"output.reference.cnn\"\n}"
                  },
                  "position": 8,
                  "prefix": "--output",
                  "separate": true
                }
              ],
              "sbg:job": {
                "inputs": {
                  "reference_fasta": {
                    "class": "File",
                    "path": "/path/to/reference_fasta.ext",
                    "size": 0,
                    "secondaryFiles": [
                      {
                        "path": ".fai"
                      },
                      {
                        "path": "^.dict"
                      }
                    ]
                  },
                  "no_gc": true,
                  "no_rmask": true,
                  "antitargets_file": {
                    "class": "File",
                    "path": "/path/to/antitargets_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "target_file": {
                    "class": "File",
                    "path": "/path/to/target_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "reference_files": [
                    {
                      "class": "File",
                      "path": "/path/to/reference_files-1.ext",
                      "size": 0,
                      "secondaryFiles": []
                    },
                    {
                      "class": "File",
                      "path": "/path/to/reference_files-2.ext",
                      "size": 0,
                      "secondaryFiles": []
                    }
                  ],
                  "male_reference": true,
                  "no_edge": true
                },
                "allocatedResources": {
                  "mem": 1000,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1476811326,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "hints": [
                {
                  "class": "DockerRequirement",
                  "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
                  "dockerImageId": ""
                },
                {
                  "class": "sbg:CPURequirement",
                  "value": 1
                },
                {
                  "class": "sbg:MemRequirement",
                  "value": 1000
                }
              ],
              "sbg:id": "milan.domazet/cnvkit-test/cnvkit-reference/6",
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1459788409,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1459788944,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1459789882,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 3,
                  "sbg:modifiedOn": 1459789927,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 4,
                  "sbg:modifiedOn": 1459790190,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 5,
                  "sbg:modifiedOn": 1459961236,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 6,
                  "sbg:modifiedOn": 1476811326,
                  "sbg:revisionNotes": "Added secondary file input for reference_fasta."
                }
              ],
              "sbg:image_url": null,
              "outputs": [
                {
                  "id": "#reference_output",
                  "sbg:fileTypes": "CNN",
                  "outputBinding": {
                    "glob": "*.cnn"
                  },
                  "label": "Reference output",
                  "description": "Reference output.",
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "temporaryFailCodes": [],
              "sbg:createdBy": "milan.domazet",
              "baseCommand": [
                "cnvkit.py",
                "reference"
              ],
              "sbg:modifiedBy": "milan.domazet",
              "id": "milan.domazet/cnvkit-test/cnvkit-reference/6",
              "sbg:revisionNotes": "Added secondary file input for reference_fasta.",
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1459788409,
              "x": 847,
              "y": 761,
              "sbg:revision": 6,
              "inputs": [
                {
                  "id": "#target_file",
                  "sbg:altPrefix": "-t",
                  "sbg:category": "Optional arguments",
                  "sbg:fileTypes": "BED,INTERVALS,INTERVAL,LIST",
                  "required": false,
                  "label": "Target intervals",
                  "description": "Target intervals (.bed or .list).",
                  "inputBinding": {
                    "prefix": "--targets",
                    "position": 2,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "File"
                  ]
                },
                {
                  "id": "#reference_files",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "CNN",
                  "required": false,
                  "label": "Rerence files",
                  "description": "Normal-sample target or antitarget .cnn files.",
                  "inputBinding": {
                    "position": 0,
                    "sbg:cmdInclude": true,
                    "itemSeparator": null,
                    "separate": true
                  },
                  "type": [
                    "null",
                    {
                      "items": "File",
                      "type": "array",
                      "name": "reference_files"
                    }
                  ]
                },
                {
                  "id": "#reference_fasta",
                  "sbg:altPrefix": "-f",
                  "sbg:category": "Optional arguments",
                  "sbg:fileTypes": "FASTA,FA",
                  "required": false,
                  "label": "Reference genome",
                  "description": "Reference genome, FASTA format (e.g. UCSC hg19.fa).",
                  "inputBinding": {
                    "secondaryFiles": [
                      ".fai",
                      "^.dict"
                    ],
                    "position": 1,
                    "sbg:cmdInclude": true,
                    "prefix": "--fasta",
                    "separate": true
                  },
                  "type": [
                    "null",
                    "File"
                  ]
                },
                {
                  "id": "#no_rmask",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "No RMask",
                  "description": "Skip RepeatMasker correction.",
                  "inputBinding": {
                    "prefix": "--no-rmask",
                    "position": 7,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#no_gc",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "No GC",
                  "description": "Skip GC correction.",
                  "inputBinding": {
                    "prefix": "--no-gc",
                    "position": 5,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#no_edge",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "No edge",
                  "description": "Skip edge-effect correction.",
                  "inputBinding": {
                    "prefix": "--no-edge",
                    "position": 6,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "sbg:stageInput": null,
                  "id": "#male_reference",
                  "sbg:altPrefix": "-y",
                  "sbg:category": "Optional arguments",
                  "sbg:includeInPorts": true,
                  "required": false,
                  "label": "Male reference",
                  "sbg:toolDefaultValue": "False",
                  "inputBinding": {
                    "prefix": "--male-reference",
                    "position": 4,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "description": "Create a male reference: shift female samples' chrX log-coverage by -1, so the reference chrX average is -1. Otherwise, shift male samples' chrX by +1, so the reference chrX average is 0."
                },
                {
                  "id": "#antitargets_file",
                  "sbg:altPrefix": "-a",
                  "sbg:category": "Optional arguments",
                  "sbg:fileTypes": "BED,INTERVALS,INTERVAL,LIST",
                  "required": false,
                  "label": "Antitarget intervals",
                  "description": "Antitarget intervals (.bed or .list).",
                  "inputBinding": {
                    "prefix": "--antitargets",
                    "position": 3,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "sbg:latestRevision": 6,
              "sbg:cmdPreview": "cnvkit.py reference --output output.reference.cnn",
              "label": "cnvkit-reference",
              "description": "",
              "sbg:contributors": [
                "milan.domazet"
              ]
            },
            "sbg:x": 847,
            "inputs": [
              {
                "id": "#cnvkit_reference.target_file"
              },
              {
                "id": "#cnvkit_reference.reference_files",
                "source": [
                  "#SBG_FlattenLists.output_list"
                ]
              },
              {
                "id": "#cnvkit_reference.reference_fasta",
                "source": [
                  "#reference"
                ]
              },
              {
                "id": "#cnvkit_reference.no_rmask"
              },
              {
                "id": "#cnvkit_reference.no_gc"
              },
              {
                "id": "#cnvkit_reference.no_edge"
              },
              {
                "id": "#cnvkit_reference.male_reference",
                "source": [
                  "#male_reference"
                ]
              },
              {
                "id": "#cnvkit_reference.antitargets_file"
              }
            ],
            "outputs": [
              {
                "id": "#cnvkit_reference.reference_output"
              }
            ],
            "sbg:y": 761
          },
          {
            "id": "#SBG_FlattenLists",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "successCodes": [],
              "sbg:sbgMaintained": false,
              "sbg:toolAuthor": "Seven Bridges",
              "sbg:id": "bix-demo/sbgtools-demo/sbg-flattenlists/4",
              "sbg:project": "bix-demo/sbgtools-demo",
              "arguments": [],
              "sbg:job": {
                "inputs": {
                  "input_list": [
                    {
                      "class": "File",
                      "path": "/path/to/input_list-1.ext",
                      "size": 0,
                      "secondaryFiles": []
                    },
                    {
                      "class": "File",
                      "path": "/path/to/input_list-2.ext",
                      "size": 0,
                      "secondaryFiles": []
                    }
                  ]
                },
                "allocatedResources": {
                  "mem": 1000,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1488288600,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "sbg:cmdPreview": "echo \"Globe for *.ext extensions\"",
              "hints": [
                {
                  "class": "sbg:CPURequirement",
                  "value": 1
                },
                {
                  "class": "sbg:MemRequirement",
                  "value": 1000
                },
                {
                  "class": "DockerRequirement",
                  "dockerPull": "ubuntu:14.04",
                  "dockerImageId": ""
                }
              ],
              "sbg:categories": [
                "Other"
              ],
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "mladenlSBG",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1458660825,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "mladenlSBG",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1470401111,
                  "sbg:revisionNotes": "Removed inheritance of metadata on output, since now metadata is available using stage input option."
                },
                {
                  "sbg:modifiedBy": "mladenlSBG",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1470401512,
                  "sbg:revisionNotes": "echo command added"
                },
                {
                  "sbg:modifiedBy": "mladenlSBG",
                  "sbg:revision": 3,
                  "sbg:modifiedOn": 1475066410,
                  "sbg:revisionNotes": "Changed output globe."
                },
                {
                  "sbg:modifiedBy": "mladenlSBG",
                  "sbg:revision": 4,
                  "sbg:modifiedOn": 1488288600,
                  "sbg:revisionNotes": "Fixed to work with more than two lists."
                }
              ],
              "sbg:license": "Apache License 2.0",
              "sbg:createdBy": "mladenlSBG",
              "temporaryFailCodes": [],
              "outputs": [
                {
                  "outputBinding": {
                    "secondaryFiles": [
                      ".bai",
                      "^.bai",
                      ".fai",
                      "^.fai",
                      ".ixd",
                      "^.idx",
                      ".tbi",
                      "^.tbi"
                    ],
                    "glob": {
                      "engine": "#cwl-js-engine",
                      "class": "Expression",
                      "script": "{\n  if($job.inputs.input_list){\n    glob_list = []\n    all_list = [].concat($job.inputs.input_list)\n    i = 0\n\n    while(i<all_list.length){\n\n      if(Array.isArray(all_list[i])==true && all_list[i]){\n        if (all_list[i]){\n          j = 0\n          temp = [].concat(all_list[i])\n          while(j<temp.length){\n            if(temp[j]){\n              glob=\"*.\" + temp[j].path.split(\"/\").pop().split(\".\").pop()\n              if (!(glob_list.indexOf(glob)>-1)) {\n                glob_list = glob_list.concat(glob)\n              }\n            }\n            j++\n          }\n        }\n\n      }\n      else{\n        if(all_list[i]){\n          glob=\"*.\" + all_list[i].path.split(\"/\").pop().split(\".\").pop()\n          if (!(glob_list.indexOf(glob)>-1)) {\n              glob_list = glob_list.concat(glob)\n            }\n        }\n      }\n      i++\n    }\n\n    if(glob_list.length==1){\n      return glob_list[0]\n      }\n\n    else{ \n    glob_expression = \"{\"\n    k = 0\n    while(k<glob_list.length){\n      glob_expression = glob_expression.concat(glob_list[k])\n      if(k<glob_list.length-1){\n        glob_expression = glob_expression.concat(\",\")\n        }\n      k++\n    }\n    glob_expression = glob_expression.concat(\"}\")\n    return glob_expression\n    }\n  }\n}"
                    }
                  },
                  "label": "Output list of files",
                  "description": "Single list of files that combines all files from all inputs.",
                  "id": "#output_list",
                  "type": [
                    "null",
                    {
                      "items": "File",
                      "type": "array"
                    }
                  ]
                }
              ],
              "sbg:toolkitVersion": "1.0",
              "baseCommand": [
                "echo",
                "\"Globe",
                "for",
                {
                  "engine": "#cwl-js-engine",
                  "class": "Expression",
                  "script": "{\n  //check if the input list is provided or not\n  if($job.inputs.input_list){\n    //create lists for all globs and new list for inputs in case of single file input, \n    //so len can be fetched\n    glob_list = []\n    all_list = [].concat($job.inputs.input_list)\n    i = 0\n\t\n    //iteration through the list\n    while(i<all_list.length){\n\t  \n      //check if the element is a list\n      if(Array.isArray(all_list[i])==true && all_list[i]){\n        //check if the list contains any elements\n        if (all_list[i]){\n          j = 0\n          temp = [].concat(all_list[i])\n          while(j<temp.length){\n            //iteration through the list, get globs that are unique and not found already\n            if(temp[j]){\n              glob=\"*.\" + temp[j].path.split(\"/\").pop().split(\".\").pop()\n              if (!(glob_list.indexOf(glob)>-1)) {\n                glob_list = glob_list.concat(glob)\n              }\n            }\n            j++\n          }\n        }\n\n      }\n      else{\n        //for single files, just get glob if it's unique\n        if(all_list[i]){\n          glob=\"*.\" + all_list[i].path.split(\"/\").pop().split(\".\").pop()\n          if (!(glob_list.indexOf(glob)>-1)) {\n              glob_list = glob_list.concat(glob)\n            }\n        }\n      }\n      i++\n    }\n\t\n    //for single globs, just return the glob\n    if(glob_list.length==1){\n      return glob_list[0]\n      }\n\n    else{ \n      //if multiple globs, the return has to be in form of {glob1,glob2,...}\n    glob_expression = \"{\"\n    k = 0\n    while(k<glob_list.length){\n      glob_expression = glob_expression.concat(glob_list[k])\n      if(k<glob_list.length-1){\n        glob_expression = glob_expression.concat(\",\")\n        }\n      k++\n    }\n    glob_expression = glob_expression.concat(\"}\")\n    return glob_expression\n    }\n  }\n}"
                },
                "extensions\""
              ],
              "sbg:modifiedBy": "mladenlSBG",
              "id": "bix-demo/sbgtools-demo/sbg-flattenlists/4",
              "sbg:revisionNotes": "Fixed to work with more than two lists.",
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1458660825,
              "x": 689.2308589720893,
              "y": 907.6924059376944,
              "sbg:revision": 4,
              "inputs": [
                {
                  "id": "#input_list",
                  "sbg:category": "File inputs",
                  "label": "Input list",
                  "description": "List of inputs, can be any combination of lists of files and single files, it will be combined into a single list of files at the output.",
                  "required": false,
                  "type": [
                    "null",
                    {
                      "items": "File",
                      "type": "array"
                    }
                  ],
                  "sbg:stageInput": "link"
                }
              ],
              "sbg:toolkit": "SBGTools",
              "sbg:latestRevision": 4,
              "sbg:image_url": null,
              "label": "SBG FlattenLists",
              "description": "Main purpose of this tool is to merge two separate file lists into a single list. If those list contain secondary files such as BAI, FAI and IDX, those files will be propagated also.",
              "sbg:contributors": [
                "mladenlSBG"
              ]
            },
            "sbg:x": 689.2308589720893,
            "inputs": [
              {
                "id": "#SBG_FlattenLists.input_list",
                "source": [
                  "#cnkit_coverage_2.coverage_file",
                  "#cnkit_coverage_3.coverage_file"
                ]
              }
            ],
            "outputs": [
              {
                "id": "#SBG_FlattenLists.output_list"
              }
            ],
            "sbg:y": 907.6924059376944
          },
          {
            "id": "#cnkit_coverage_2",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "successCodes": [],
              "sbg:sbgMaintained": false,
              "sbg:project": "milan.domazet/cnvkit-test",
              "arguments": [
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  var fileName=$job.inputs.bam_file.path.replace(/^.*[\\\\\\/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  if(($job.inputs.interval_file.path).indexOf(\"antitarget\") > -1){\n   return fileName+\".antitarget.coverage.cnn\"\n  }\n  else return fileName+\".target.coverage.cnn\"\n}"
                  },
                  "position": 4,
                  "prefix": "--output",
                  "separate": true
                }
              ],
              "sbg:job": {
                "inputs": {
                  "count": true,
                  "bam_file": {
                    "class": "File",
                    "path": "/path/to/bam_file.ext",
                    "size": 0,
                    "secondaryFiles": [
                      {
                        "path": ".bai"
                      }
                    ]
                  },
                  "interval_file": {
                    "class": "File",
                    "path": "/path/to/interval_file.antitarget.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "min_mapq": 8
                },
                "allocatedResources": {
                  "mem": 1000,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1476811242,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "hints": [
                {
                  "class": "DockerRequirement",
                  "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
                  "dockerImageId": ""
                },
                {
                  "class": "sbg:CPURequirement",
                  "value": 1
                },
                {
                  "class": "sbg:MemRequirement",
                  "value": 1000
                }
              ],
              "sbg:id": "milan.domazet/cnvkit-test/cnkit-coverage/5",
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1459787673,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1459787936,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1459788026,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 3,
                  "sbg:modifiedOn": 1459788105,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 4,
                  "sbg:modifiedOn": 1460114335,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 5,
                  "sbg:modifiedOn": 1476811242,
                  "sbg:revisionNotes": "Added .bai as secondary for BAM file."
                }
              ],
              "sbg:image_url": null,
              "outputs": [
                {
                  "id": "#coverage_file",
                  "sbg:fileTypes": "CNN",
                  "outputBinding": {
                    "sbg:inheritMetadataFrom": "#bam_file",
                    "glob": "*.cnn"
                  },
                  "label": "Coverage output file",
                  "description": "Coverage output file.",
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "temporaryFailCodes": [],
              "sbg:createdBy": "milan.domazet",
              "baseCommand": [
                "cnvkit.py",
                "coverage"
              ],
              "sbg:modifiedBy": "milan.domazet",
              "id": "milan.domazet/cnvkit-test/cnkit-coverage/5",
              "sbg:revisionNotes": "Added .bai as secondary for BAM file.",
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1459787673,
              "x": 495.76928236780935,
              "y": 856.6924132383824,
              "sbg:revision": 5,
              "inputs": [
                {
                  "id": "#min_mapq",
                  "sbg:altPrefix": "-q",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "0",
                  "label": "Minimum mapping quality score",
                  "description": "Minimum mapping quality score (phred scale 0-60) to count a read for coverage depth.",
                  "inputBinding": {
                    "prefix": "--min-mapq",
                    "position": 3,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "int"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#interval_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "BED,LIST",
                  "required": true,
                  "label": "Interval file",
                  "description": "Intervals.",
                  "inputBinding": {
                    "position": 1,
                    "sbg:cmdInclude": true,
                    "loadContents": false,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                },
                {
                  "id": "#count",
                  "sbg:altPrefix": "-c",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "Count read midpoints",
                  "description": "Get read depths by counting read midpoints within each bin. (An alternative algorithm).",
                  "inputBinding": {
                    "prefix": "--count",
                    "position": 2,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#bam_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "BAM",
                  "required": true,
                  "label": "BAM file input",
                  "description": "Mapped sequence reads.",
                  "inputBinding": {
                    "secondaryFiles": [
                      ".bai"
                    ],
                    "position": 0,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                }
              ],
              "sbg:latestRevision": 5,
              "sbg:cmdPreview": "cnvkit.py coverage  /path/to/bam_file.ext  /path/to/interval_file.antitarget.ext --output bam_file.antitarget.coverage.cnn",
              "label": "cnkit-coverage",
              "description": "",
              "sbg:contributors": [
                "milan.domazet"
              ]
            },
            "sbg:x": 495.76928236780935,
            "scatter": "#cnkit_coverage_2.bam_file",
            "inputs": [
              {
                "id": "#cnkit_coverage_2.min_mapq"
              },
              {
                "id": "#cnkit_coverage_2.interval_file",
                "source": [
                  "#antitarget_bed"
                ]
              },
              {
                "id": "#cnkit_coverage_2.count"
              },
              {
                "id": "#cnkit_coverage_2.bam_file",
                "source": [
                  "#normal_bam"
                ]
              }
            ],
            "outputs": [
              {
                "id": "#cnkit_coverage_2.coverage_file"
              }
            ],
            "sbg:y": 856.6924132383824
          },
          {
            "id": "#cnkit_coverage_3",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "successCodes": [],
              "sbg:sbgMaintained": false,
              "sbg:project": "milan.domazet/cnvkit-test",
              "arguments": [
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  var fileName=$job.inputs.bam_file.path.replace(/^.*[\\\\\\/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  if(($job.inputs.interval_file.path).indexOf(\"antitarget\") > -1){\n   return fileName+\".antitarget.coverage.cnn\"\n  }\n  else return fileName+\".target.coverage.cnn\"\n}"
                  },
                  "position": 4,
                  "prefix": "--output",
                  "separate": true
                }
              ],
              "sbg:job": {
                "inputs": {
                  "count": true,
                  "bam_file": {
                    "class": "File",
                    "path": "/path/to/bam_file.ext",
                    "size": 0,
                    "secondaryFiles": [
                      {
                        "path": ".bai"
                      }
                    ]
                  },
                  "interval_file": {
                    "class": "File",
                    "path": "/path/to/interval_file.antitarget.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "min_mapq": 8
                },
                "allocatedResources": {
                  "mem": 1000,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1476811242,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "hints": [
                {
                  "class": "DockerRequirement",
                  "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
                  "dockerImageId": ""
                },
                {
                  "class": "sbg:CPURequirement",
                  "value": 1
                },
                {
                  "class": "sbg:MemRequirement",
                  "value": 1000
                }
              ],
              "sbg:id": "milan.domazet/cnvkit-test/cnkit-coverage/5",
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1459787673,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1459787936,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1459788026,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 3,
                  "sbg:modifiedOn": 1459788105,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 4,
                  "sbg:modifiedOn": 1460114335,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 5,
                  "sbg:modifiedOn": 1476811242,
                  "sbg:revisionNotes": "Added .bai as secondary for BAM file."
                }
              ],
              "sbg:image_url": null,
              "outputs": [
                {
                  "id": "#coverage_file",
                  "sbg:fileTypes": "CNN",
                  "outputBinding": {
                    "sbg:inheritMetadataFrom": "#bam_file",
                    "glob": "*.cnn"
                  },
                  "label": "Coverage output file",
                  "description": "Coverage output file.",
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "temporaryFailCodes": [],
              "sbg:createdBy": "milan.domazet",
              "baseCommand": [
                "cnvkit.py",
                "coverage"
              ],
              "sbg:modifiedBy": "milan.domazet",
              "id": "milan.domazet/cnvkit-test/cnkit-coverage/5",
              "sbg:revisionNotes": "Added .bai as secondary for BAM file.",
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1459787673,
              "x": 500.0001495801555,
              "y": 967.9232710282561,
              "sbg:revision": 5,
              "inputs": [
                {
                  "id": "#min_mapq",
                  "sbg:altPrefix": "-q",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "0",
                  "label": "Minimum mapping quality score",
                  "description": "Minimum mapping quality score (phred scale 0-60) to count a read for coverage depth.",
                  "inputBinding": {
                    "prefix": "--min-mapq",
                    "position": 3,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "int"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#interval_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "BED,LIST",
                  "required": true,
                  "label": "Interval file",
                  "description": "Intervals.",
                  "inputBinding": {
                    "position": 1,
                    "sbg:cmdInclude": true,
                    "loadContents": false,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                },
                {
                  "id": "#count",
                  "sbg:altPrefix": "-c",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "False",
                  "label": "Count read midpoints",
                  "description": "Get read depths by counting read midpoints within each bin. (An alternative algorithm).",
                  "inputBinding": {
                    "prefix": "--count",
                    "position": 2,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "boolean"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#bam_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "BAM",
                  "required": true,
                  "label": "BAM file input",
                  "description": "Mapped sequence reads.",
                  "inputBinding": {
                    "secondaryFiles": [
                      ".bai"
                    ],
                    "position": 0,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                }
              ],
              "sbg:latestRevision": 5,
              "sbg:cmdPreview": "cnvkit.py coverage  /path/to/bam_file.ext  /path/to/interval_file.antitarget.ext --output bam_file.antitarget.coverage.cnn",
              "label": "cnkit-coverage",
              "description": "",
              "sbg:contributors": [
                "milan.domazet"
              ]
            },
            "sbg:x": 500.0001495801555,
            "scatter": "#cnkit_coverage_3.bam_file",
            "inputs": [
              {
                "id": "#cnkit_coverage_3.min_mapq"
              },
              {
                "id": "#cnkit_coverage_3.interval_file",
                "source": [
                  "#target_bed"
                ]
              },
              {
                "id": "#cnkit_coverage_3.count"
              },
              {
                "id": "#cnkit_coverage_3.bam_file",
                "source": [
                  "#normal_bam"
                ]
              }
            ],
            "outputs": [
              {
                "id": "#cnkit_coverage_3.coverage_file"
              }
            ],
            "sbg:y": 967.9232710282561
          },
          {
            "id": "#cnvkit_call",
            "run": {
              "sbg:validationErrors": [],
              "class": "CommandLineTool",
              "sbg:sbgMaintained": false,
              "sbg:project": "milan.domazet/cnvkit-test",
              "arguments": [
                {
                  "valueFrom": {
                    "engine": "#cwl-js-engine",
                    "class": "Expression",
                    "script": "{\n  var fileName=$job.inputs.copy_ratios_file.path.replace(/^.*[/]/, '');\n  fileName=fileName.substr(0,fileName.lastIndexOf(\".\"));\n  return fileName+\".call.cns\"\n}\n"
                  },
                  "position": 9,
                  "prefix": "--output",
                  "separate": true
                }
              ],
              "sbg:job": {
                "inputs": {
                  "center": "mean",
                  "purity": 3.0999743244396463,
                  "gender": "male",
                  "method": "threshold",
                  "copy_ratios_file": {
                    "class": "File",
                    "path": "/path/to/copy_ratios_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "vcf_file": {
                    "class": "File",
                    "path": "/path/to/vcf_file.ext",
                    "size": 0,
                    "secondaryFiles": []
                  },
                  "threshold": [
                    10.681866457750699,
                    8.183296399047292
                  ],
                  "male_reference": true,
                  "ploidy": 7
                },
                "allocatedResources": {
                  "mem": 1000,
                  "cpu": 1
                }
              },
              "sbg:modifiedOn": 1492034291,
              "requirements": [
                {
                  "class": "ExpressionEngineRequirement",
                  "id": "#cwl-js-engine",
                  "requirements": [
                    {
                      "class": "DockerRequirement",
                      "dockerPull": "rabix/js-engine"
                    }
                  ]
                }
              ],
              "cwlVersion": "sbg:draft-2",
              "hints": [
                {
                  "class": "DockerRequirement",
                  "dockerPull": "images.sbgenomics.com/milan_domazet/cnvkit:0.7.9",
                  "dockerImageId": ""
                },
                {
                  "class": "sbg:CPURequirement",
                  "value": 1
                },
                {
                  "class": "sbg:MemRequirement",
                  "value": 1000
                }
              ],
              "sbg:id": "milan.domazet/cnvkit-test/cnvkit-call/5",
              "sbg:revisionsInfo": [
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 0,
                  "sbg:modifiedOn": 1459852691,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 1,
                  "sbg:modifiedOn": 1459853673,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "milan.domazet",
                  "sbg:revision": 2,
                  "sbg:modifiedOn": 1459853707,
                  "sbg:revisionNotes": null
                },
                {
                  "sbg:modifiedBy": "ognjenm",
                  "sbg:revision": 3,
                  "sbg:modifiedOn": 1492012803,
                  "sbg:revisionNotes": "Added thresholds expression"
                },
                {
                  "sbg:modifiedBy": "ognjenm",
                  "sbg:revision": 4,
                  "sbg:modifiedOn": 1492013356,
                  "sbg:revisionNotes": "Ploidy float"
                },
                {
                  "sbg:modifiedBy": "ognjenm",
                  "sbg:revision": 5,
                  "sbg:modifiedOn": 1492034291,
                  "sbg:revisionNotes": "Reverted to 3"
                }
              ],
              "sbg:image_url": null,
              "outputs": [
                {
                  "id": "#call_file",
                  "sbg:fileTypes": "CNS",
                  "outputBinding": {
                    "sbg:inheritMetadataFrom": "#copy_ratios_file",
                    "glob": "*.cns"
                  },
                  "label": "Call output file",
                  "description": "Call output (.CNS) file.",
                  "type": [
                    "null",
                    "File"
                  ]
                }
              ],
              "sbg:createdBy": "milan.domazet",
              "baseCommand": [
                "cnvkit.py",
                "call"
              ],
              "id": "https://api.sbgenomics.com/v2/apps/milan.domazet/cnvkit-test/cnvkit-call/5/raw/",
              "sbg:revisionNotes": "Reverted to 3",
              "sbg:appVersion": [
                "sbg:draft-2"
              ],
              "stdout": "",
              "stdin": "",
              "sbg:createdOn": 1459852691,
              "successCodes": [],
              "sbg:modifiedBy": "ognjenm",
              "sbg:revision": 5,
              "inputs": [
                {
                  "id": "#copy_ratios_file",
                  "sbg:category": "Positional arguments",
                  "sbg:fileTypes": "CNR,CNS",
                  "label": "Copy ratios file",
                  "description": "Copy ratios (.cnr or .cns).",
                  "inputBinding": {
                    "position": 0,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "File"
                  ]
                },
                {
                  "id": "#center",
                  "sbg:category": "Optional arguments",
                  "label": "Center",
                  "description": "Re-center the log2 ratio values using this estimate of the center or average value.",
                  "inputBinding": {
                    "prefix": "--center",
                    "position": 1,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    {
                      "type": "enum",
                      "name": "center",
                      "symbols": [
                        "mean",
                        "median",
                        "mode",
                        "biweight"
                      ]
                    }
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#method",
                  "sbg:altPrefix": "-m",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "threshold",
                  "label": "Method",
                  "description": "Calling method.",
                  "inputBinding": {
                    "prefix": "--method",
                    "position": 2,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    {
                      "type": "enum",
                      "name": "method",
                      "symbols": [
                        "threshold",
                        "clonal",
                        "none"
                      ]
                    }
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#threshold",
                  "sbg:altPrefix": "-t",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "-1.1,-0.25,0.2,0.7",
                  "label": "Hard thresholds for calling each integer copy number",
                  "description": "Hard thresholds for calling each integer copy number, separated by commas.",
                  "inputBinding": {
                    "valueFrom": {
                      "engine": "#cwl-js-engine",
                      "class": "Expression",
                      "script": "{\n \n  if ($job.inputs.threshold){\n    \n    return '--thresholds=' + $job.inputs.threshold.join(',')\n    \n  } else {\n    \n    return ''\n    \n  }\n  \n}"
                    },
                    "position": 3,
                    "sbg:cmdInclude": true,
                    "itemSeparator": ",",
                    "separate": false
                  },
                  "type": [
                    "null",
                    {
                      "items": "float",
                      "type": "array"
                    }
                  ]
                },
                {
                  "id": "#ploidy",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "2",
                  "label": "Ploidy of the sample cells",
                  "description": "Ploidy of the sample cells.",
                  "inputBinding": {
                    "prefix": "--ploidy",
                    "position": 4,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "int"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#purity",
                  "sbg:category": "Optional arguments",
                  "label": "Purity of cellularity",
                  "description": "Estimated tumor cell fraction, a.k.a. purity or cellularity.",
                  "inputBinding": {
                    "prefix": "--purity",
                    "position": 5,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "float"
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#vcf_file",
                  "sbg:altPrefix": "-v",
                  "sbg:category": "Optional arguments",
                  "sbg:fileTypes": "VCF",
                  "label": "VCF file",
                  "description": "VCF file containing variants for assigning allele frequencies and copy number.",
                  "inputBinding": {
                    "prefix": "--vcf",
                    "position": 6,
                    "sbg:cmdInclude": true,
                    "loadContents": false,
                    "separate": true
                  },
                  "type": [
                    "null",
                    "File"
                  ]
                },
                {
                  "id": "#gender",
                  "sbg:altPrefix": "-g",
                  "sbg:category": "Optional arguments",
                  "sbg:toolDefaultValue": "Guessed from chrX copy number",
                  "label": "Gender",
                  "description": "Specify the sample's gender as male or female.",
                  "inputBinding": {
                    "prefix": "--gender",
                    "position": 7,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "type": [
                    "null",
                    {
                      "type": "enum",
                      "name": "gender",
                      "symbols": [
                        "male",
                        "female"
                      ]
                    }
                  ],
                  "sbg:stageInput": null
                },
                {
                  "id": "#male_reference",
                  "sbg:altPrefix": "-y",
                  "sbg:category": "Optional arguments",
                  "sbg:includeInPorts": true,
                  "label": "Male reference",
                  "description": "Was a male reference used? If so, expect half ploidy on chrX and chrY; otherwise, only chrY has half ploidy. In CNVkit, if a male reference was used, the \"neutral\" copy number (ploidy) of chrX is 1; chrY is haploid for either gender reference.",
                  "inputBinding": {
                    "prefix": "--male-reference",
                    "position": 8,
                    "sbg:cmdInclude": true,
                    "separate": true
                  },
                  "sbg:stageInput": null,
                  "type": [
                    "null",
                    "boolean"
                  ]
                }
              ],
              "sbg:contributors": [
                "ognjenm",
                "milan.domazet"
              ],
              "sbg:latestRevision": 5,
              "sbg:projectName": "cnvkit-test",
              "sbg:cmdPreview": "cnvkit.py call  /path/to/copy_ratios_file.ext --output copy_ratios_file.call.cns",
              "label": "cnvkit-call",
              "description": "",
              "temporaryFailCodes": []
            },
            "sbg:x": 1282,
            "inputs": [
              {
                "id": "#cnvkit_call.copy_ratios_file",
                "source": [
                  "#cnvkit_segment.segment_output"
                ]
              },
              {
                "id": "#cnvkit_call.center",
                "source": [
                  "#center"
                ]
              },
              {
                "id": "#cnvkit_call.method",
                "source": [
                  "#method_1"
                ]
              },
              {
                "id": "#cnvkit_call.threshold",
                "source": [
                  "#threshold"
                ]
              },
              {
                "id": "#cnvkit_call.ploidy",
                "source": [
                  "#ploidy"
                ]
              },
              {
                "id": "#cnvkit_call.purity",
                "source": [
                  "#purity"
                ]
              },
              {
                "id": "#cnvkit_call.vcf_file"
              },
              {
                "id": "#cnvkit_call.gender",
                "source": [
                  "#gender"
                ]
              },
              {
                "id": "#cnvkit_call.male_reference",
                "source": [
                  "#male_reference"
                ]
              }
            ],
            "outputs": [
              {
                "id": "#cnvkit_call.call_file"
              }
            ],
            "sbg:y": 510
          }
        ],
        "sbg:project": "ognjenm/bms-test-run",
        "sbg:modifiedOn": 1493212467,
        "requirements": [],
        "sbg:sbgMaintained": false,
        "cwlVersion": "sbg:draft-2",
        "hints": [],
        "sbg:id": "ognjenm/bms-test-run/cnvkit-cnv-only/4",
        "sbg:revisionsInfo": [
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 0,
            "sbg:modifiedOn": 1489011526,
            "sbg:revisionNotes": "Copy of ognjenm/bms-test-run/cnvkit-pipeline/4"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 1,
            "sbg:modifiedOn": 1489011601,
            "sbg:revisionNotes": "LOH removed"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 2,
            "sbg:modifiedOn": 1489011831,
            "sbg:revisionNotes": "Changed name"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 3,
            "sbg:modifiedOn": 1489138763,
            "sbg:revisionNotes": "Exposed segment and call options"
          },
          {
            "sbg:modifiedBy": "ognjenm",
            "sbg:revision": 4,
            "sbg:modifiedOn": 1493212467,
            "sbg:revisionNotes": "Exposed male reference"
          }
        ],
        "inputs": [
          {
            "id": "#tumor_bam",
            "sbg:includeInPorts": true,
            "sbg:x": -169,
            "sbg:fileTypes": "BAM",
            "label": "tumor_bam",
            "required": true,
            "type": [
              "File"
            ],
            "sbg:y": 740
          },
          {
            "id": "#threshold",
            "sbg:altPrefix": "-t",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "-1.1,-0.25,0.2,0.7",
            "label": "Hard thresholds for calling each integer copy number",
            "description": "Hard thresholds for calling each integer copy number, separated by commas.",
            "type": [
              "null",
              {
                "items": "float",
                "type": "array",
                "name": "threshold"
              }
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#target_bed",
            "sbg:includeInPorts": true,
            "sbg:x": -192,
            "sbg:fileTypes": "BED,LIST",
            "label": "target_bed",
            "required": true,
            "type": [
              "File"
            ],
            "sbg:y": 421
          },
          {
            "id": "#significance_threshold",
            "sbg:altPrefix": "-t",
            "sbg:category": "Optional arguments",
            "label": "Significance threshold",
            "description": "Significance threshold (p-value or FDR, depending on method) to accept breakpoints during segmentation.",
            "type": [
              "null",
              "float"
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#reference",
            "sbg:x": -14.923071813301704,
            "sbg:fileTypes": "FASTA,FA",
            "label": "reference",
            "required": true,
            "type": [
              "File"
            ],
            "sbg:y": 861.4616589870726
          },
          {
            "id": "#purity",
            "sbg:category": "Optional arguments",
            "label": "Purity of cellularity",
            "description": "Estimated tumor cell fraction, a.k.a. purity or cellularity.",
            "type": [
              "null",
              "float"
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#ploidy",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "2",
            "label": "Ploidy of the sample cells",
            "description": "Ploidy of the sample cells.",
            "sbg:stageInput": null,
            "type": [
              "null",
              "int"
            ]
          },
          {
            "id": "#normal_bam",
            "sbg:includeInPorts": true,
            "sbg:x": -152.30774463563517,
            "sbg:fileTypes": "BAM",
            "secondaryFiles": [
              ".bai"
            ],
            "label": "normal_bam",
            "required": true,
            "sbg:y": 984.6155047727095,
            "type": [
              "File"
            ]
          },
          {
            "id": "#method_1",
            "sbg:altPrefix": "-m",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "threshold",
            "label": "Method",
            "description": "Calling method.",
            "type": [
              "null",
              {
                "type": "enum",
                "name": "method",
                "symbols": [
                  "threshold",
                  "clonal",
                  "none"
                ]
              }
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#method",
            "sbg:altPrefix": "-m",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "cbs",
            "label": "Segmentation method",
            "description": "Segmentation method (CBS, HaarSeg, or Fused Lasso).",
            "type": [
              "null",
              {
                "type": "enum",
                "name": "method",
                "symbols": [
                  "cbs",
                  "haar",
                  "flasso"
                ]
              }
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#male_reference",
            "sbg:includeInPorts": false,
            "sbg:x": 403.0768082071268,
            "label": "male_reference",
            "type": [
              "null",
              "boolean"
            ],
            "sbg:y": 1106.1538723601388
          },
          {
            "id": "#gender",
            "sbg:altPrefix": "-g",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "Guessed from chrX copy number",
            "label": "Gender",
            "description": "Specify the sample's gender as male or female.",
            "type": [
              "null",
              {
                "type": "enum",
                "name": "gender",
                "symbols": [
                  "male",
                  "female"
                ]
              }
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#drop_outliers",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "10",
            "label": "Drop outliers",
            "description": "Drop outlier bins more than this many multiples of the 95th quantile away from the average within a rolling window. Set to 0 for no outlier filtering.",
            "sbg:stageInput": null,
            "type": [
              "null",
              "int"
            ]
          },
          {
            "id": "#drop_low_coverage",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "False",
            "label": "Drop low coverage",
            "description": "Drop very-low-coverage bins before segmentation to avoid false-positive deletions in poor-quality tumor samples.",
            "sbg:stageInput": null,
            "type": [
              "null",
              "boolean"
            ]
          },
          {
            "id": "#dataframe",
            "sbg:category": "Optional arguments",
            "sbg:toolDefaultValue": "False",
            "label": "Save dataframe",
            "description": "Save the raw R dataframe emitted by CBS or Fused Lasso. (Useful for debugging.)",
            "sbg:stageInput": null,
            "type": [
              "null",
              "boolean"
            ]
          },
          {
            "id": "#center",
            "sbg:category": "Optional arguments",
            "label": "Center",
            "description": "Re-center the log2 ratio values using this estimate of the center or average value.",
            "type": [
              "null",
              {
                "type": "enum",
                "name": "center",
                "symbols": [
                  "mean",
                  "median",
                  "mode",
                  "biweight"
                ]
              }
            ],
            "sbg:stageInput": null
          },
          {
            "id": "#antitarget_bed",
            "sbg:includeInPorts": true,
            "sbg:x": -196,
            "sbg:fileTypes": "BED,LIST",
            "label": "antitarget_bed",
            "required": true,
            "type": [
              "File"
            ],
            "sbg:y": 591
          }
        ],
        "outputs": [
          {
            "sbg:y": 362.10527118883635,
            "id": "#output_vcf",
            "sbg:includeInPorts": true,
            "sbg:x": 1598.9473684210525,
            "label": "output_vcf",
            "required": false,
            "source": [
              "#cnvkit_export_vcf.output_vcf"
            ],
            "type": [
              "null",
              "File"
            ]
          },
          {
            "sbg:y": 690.52636175117,
            "id": "#output_diagram_file",
            "sbg:includeInPorts": true,
            "sbg:x": 1522.3482945283922,
            "sbg:fileTypes": "PDF",
            "label": "output_diagram_file",
            "required": false,
            "source": [
              "#cnvkit_diagram.output_diagram_file"
            ],
            "type": [
              "null",
              "File"
            ]
          },
          {
            "sbg:y": 509,
            "id": "#call_file",
            "sbg:includeInPorts": true,
            "sbg:x": 1468,
            "label": "call_file",
            "required": false,
            "source": [
              "#cnvkit_call.call_file"
            ],
            "type": [
              "null",
              "File"
            ]
          }
        ],
        "sbg:createdBy": "ognjenm",
        "sbg:image_url": "https://brood.sbgenomics.com/static/ognjenm/bms-test-run/cnvkit-cnv-only/4.png",
        "y": 427.9999898274741,
        "id": "ognjenm/bms-test-run/cnvkit-cnv-only/4",
        "sbg:canvas_zoom": 0.6499999999999997,
        "sbg:revisionNotes": "Exposed male reference",
        "sbg:appVersion": [
          "sbg:draft-2"
        ],
        "sbg:canvas_y": -257,
        "sbg:createdOn": 1489011526,
        "x": 834.6666463216148,
        "sbg:modifiedBy": "ognjenm",
        "sbg:revision": 4,
        "sbg:canvas_x": -51,
        "sbg:latestRevision": 4,
        "sbg:projectName": "BMS Pipelines - Somatic, CNV, LOH",
        "label": "cnvkit-cnv-only",
        "description": "",
        "sbg:contributors": [
          "ognjenm"
        ]
      },
      "sbg:x": 834.6666463216148,
      "inputs": [
        {
          "id": "#cnvkit_cnv_only.tumor_bam",
          "source": [
            "#Sambamba_Index_1.indexed_bam"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.threshold",
          "source": [
            "#threshold"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.target_bed",
          "source": [
            "#cnvkit_target.target_bed"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.significance_threshold",
          "source": [
            "#significance_threshold"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.reference",
          "source": [
            "#SBG_FASTA_Indices.fasta_reference"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.purity",
          "source": [
            "#purity"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.ploidy",
          "source": [
            "#ploidy"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.normal_bam",
          "source": [
            "#Sambamba_Index.indexed_bam"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.method_1",
          "source": [
            "#method_1"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.method",
          "source": [
            "#method"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.male_reference",
          "source": [
            "#male_reference"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.gender",
          "source": [
            "#gender"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.drop_outliers",
          "source": [
            "#drop_outliers"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.drop_low_coverage",
          "source": [
            "#drop_low_coverage"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.dataframe",
          "source": [
            "#dataframe"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.center",
          "source": [
            "#center"
          ]
        },
        {
          "id": "#cnvkit_cnv_only.antitarget_bed",
          "source": [
            "#cnvkit_antitarget.antitarget_bed"
          ]
        }
      ],
      "outputs": [
        {
          "id": "#cnvkit_cnv_only.output_vcf"
        },
        {
          "id": "#cnvkit_cnv_only.output_diagram_file"
        },
        {
          "id": "#cnvkit_cnv_only.call_file"
        }
      ],
      "sbg:y": 427.9999898274741
    }
  ],
  "sbg:id": "christian_frech/dev/cnv-loh-tumor-only/0",
  "sbg:revisionsInfo": [
    {
      "sbg:modifiedBy": "christian_frech",
      "sbg:revision": 0,
      "sbg:modifiedOn": 1495725354,
      "sbg:revisionNotes": "Copy of uros_sipetic/bms-th-validation-dev/cnv-loh-tumor-only/3"
    }
  ],
  "inputs": [
    {
      "id": "#tumor_bam",
      "sbg:includeInPorts": true,
      "sbg:x": 7.666666666666657,
      "sbg:fileTypes": "BAM, CRAM",
      "label": "Tumor BAM",
      "sbg:y": 459.0000000000001,
      "type": [
        "File"
      ]
    },
    {
      "id": "#reference",
      "sbg:suggestedValue": {
        "path": "5772b6d8507c1752674486e6",
        "name": "human_g1k_v37_decoy.fasta",
        "class": "File"
      },
      "sbg:x": 15,
      "label": "reference",
      "sbg:y": 571.3333333333335,
      "type": [
        "File"
      ]
    },
    {
      "id": "#bed_file",
      "sbg:x": 21.33333333333333,
      "sbg:fileTypes": "BED,INTERVALS,INTERVAL,LIST",
      "label": "bed_file",
      "sbg:y": 685.6666666666669,
      "type": [
        "null",
        "File"
      ]
    },
    {
      "id": "#annotation_file",
      "sbg:x": 112.00001780192059,
      "sbg:fileTypes": "TXT,TEXT",
      "label": "annotation_file",
      "sbg:y": 809.3333333333335,
      "type": [
        "null",
        "File"
      ]
    },
    {
      "id": "#normal_bam",
      "sbg:includeInPorts": true,
      "sbg:x": 92,
      "sbg:fileTypes": "BAM, CRAM",
      "label": "Normal BAM",
      "sbg:y": 262,
      "type": [
        {
          "items": "File",
          "type": "array"
        }
      ]
    },
    {
      "id": "#threshold",
      "sbg:altPrefix": "-t",
      "sbg:category": "Optional arguments",
      "sbg:toolDefaultValue": "-1.1,-0.25,0.2,0.7",
      "label": "Hard thresholds for calling each integer copy number",
      "description": "Hard thresholds for calling each integer copy number, separated by commas.",
      "type": [
        "null",
        {
          "items": "float",
          "type": "array",
          "name": "threshold"
        }
      ],
      "sbg:stageInput": null
    },
    {
      "id": "#significance_threshold",
      "sbg:altPrefix": "-t",
      "sbg:category": "Optional arguments",
      "label": "Significance threshold",
      "description": "Significance threshold (p-value or FDR, depending on method) to accept breakpoints during segmentation.",
      "type": [
        "null",
        "float"
      ],
      "sbg:stageInput": null
    },
    {
      "id": "#purity",
      "sbg:category": "Optional arguments",
      "label": "Purity of cellularity",
      "description": "Estimated tumor cell fraction, a.k.a. purity or cellularity.",
      "type": [
        "null",
        "float"
      ],
      "sbg:stageInput": null
    },
    {
      "id": "#ploidy",
      "sbg:category": "Optional arguments",
      "sbg:toolDefaultValue": "2",
      "label": "Ploidy of the sample cells",
      "description": "Ploidy of the sample cells.",
      "sbg:stageInput": null,
      "type": [
        "null",
        "int"
      ]
    },
    {
      "id": "#method_1",
      "sbg:altPrefix": "-m",
      "sbg:category": "Optional arguments",
      "sbg:toolDefaultValue": "threshold",
      "label": "Method",
      "description": "Calling method.",
      "type": [
        "null",
        {
          "type": "enum",
          "name": "method",
          "symbols": [
            "threshold",
            "clonal",
            "none"
          ]
        }
      ],
      "sbg:stageInput": null
    },
    {
      "id": "#method",
      "sbg:altPrefix": "-m",
      "sbg:category": "Optional arguments",
      "sbg:toolDefaultValue": "cbs",
      "label": "Segmentation method",
      "description": "Segmentation method (CBS, HaarSeg, or Fused Lasso).",
      "type": [
        "null",
        {
          "type": "enum",
          "name": "method",
          "symbols": [
            "cbs",
            "haar",
            "flasso"
          ]
        }
      ],
      "sbg:stageInput": null
    },
    {
      "id": "#male_reference",
      "sbg:includeInPorts": false,
      "sbg:x": 403.0768082071268,
      "label": "male_reference",
      "required": false,
      "type": [
        "null",
        "boolean"
      ],
      "sbg:y": 1106.1538723601388
    },
    {
      "id": "#gender",
      "sbg:altPrefix": "-g",
      "sbg:category": "Optional arguments",
      "sbg:toolDefaultValue": "Guessed from chrX copy number",
      "label": "Gender",
      "description": "Specify the sample's gender as male or female.",
      "type": [
        "null",
        {
          "type": "enum",
          "name": "gender",
          "symbols": [
            "male",
            "female"
          ]
        }
      ],
      "sbg:stageInput": null
    },
    {
      "id": "#drop_outliers",
      "sbg:category": "Optional arguments",
      "sbg:toolDefaultValue": "10",
      "label": "Drop outliers",
      "description": "Drop outlier bins more than this many multiples of the 95th quantile away from the average within a rolling window. Set to 0 for no outlier filtering.",
      "sbg:stageInput": null,
      "type": [
        "null",
        "int"
      ]
    },
    {
      "id": "#drop_low_coverage",
      "sbg:category": "Optional arguments",
      "sbg:toolDefaultValue": "False",
      "label": "Drop low coverage",
      "description": "Drop very-low-coverage bins before segmentation to avoid false-positive deletions in poor-quality tumor samples.",
      "sbg:stageInput": null,
      "type": [
        "null",
        "boolean"
      ]
    },
    {
      "id": "#dataframe",
      "sbg:category": "Optional arguments",
      "sbg:toolDefaultValue": "False",
      "label": "Save dataframe",
      "description": "Save the raw R dataframe emitted by CBS or Fused Lasso. (Useful for debugging.)",
      "sbg:stageInput": null,
      "type": [
        "null",
        "boolean"
      ]
    },
    {
      "id": "#center",
      "sbg:category": "Optional arguments",
      "label": "Center",
      "description": "Re-center the log2 ratio values using this estimate of the center or average value.",
      "type": [
        "null",
        {
          "type": "enum",
          "name": "center",
          "symbols": [
            "mean",
            "median",
            "mode",
            "biweight"
          ]
        }
      ],
      "sbg:stageInput": null
    }
  ],
  "outputs": [
    {
      "sbg:y": 434.51281597487184,
      "id": "#output_archive",
      "sbg:includeInPorts": true,
      "sbg:x": 1626.3590993711962,
      "label": "Output archive CNV",
      "required": false,
      "source": [
        "#BMS_Rename_App.output_file"
      ],
      "type": [
        "null",
        {
          "items": "File",
          "type": "array",
          "name": "renamed"
        }
      ]
    },
    {
      "sbg:y": 658.4615378520878,
      "id": "#call_file",
      "sbg:includeInPorts": true,
      "sbg:x": 1132.3077435239531,
      "label": "call_file",
      "required": false,
      "source": [
        "#cnvkit_cnv_only.call_file"
      ],
      "type": [
        "null",
        {
          "items": "File",
          "type": "array"
        }
      ]
    }
  ],
  "sbg:copyOf": "uros_sipetic/bms-th-validation-dev/cnv-loh-tumor-only/3",
  "sbg:createdBy": "christian_frech",
  "sbg:image_url": "https://brood.sbgenomics.com/static/christian_frech/dev/cnv-loh-tumor-only/0.png",
  "id": "https://api.sbgenomics.com/v2/apps/christian_frech/dev/cnv-loh-tumor-only/0/raw/",
  "sbg:canvas_zoom": 0.6499999999999997,
  "sbg:revisionNotes": "Copy of uros_sipetic/bms-th-validation-dev/cnv-loh-tumor-only/3",
  "sbg:appVersion": [
    "sbg:draft-2"
  ],
  "sbg:canvas_y": -88,
  "sbg:createdOn": 1495725354,
  "sbg:modifiedBy": "christian_frech",
  "sbg:revision": 0,
  "sbg:canvas_x": -78,
  "hints": [
    {
      "class": "sbg:maxNumberOfParallelInstances",
      "value": "1"
    },
    {
      "class": "sbg:AWSInstanceType",
      "value": "c4.4xlarge"
    }
  ],
  "sbg:latestRevision": 0,
  "sbg:projectName": "dev internal",
  "label": "cnv-tumor-only",
  "description": "",
  "sbg:contributors": [
    "christian_frech"
  ]
}
