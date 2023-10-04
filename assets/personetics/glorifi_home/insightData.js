var insightDataForUi = {
    ok: true,
    requestChannel: "VANILLA_QA",
    requestType: "getInsightDetails",
    requestId: "by6IolTamM8xwikb",
    status: "200",
    statusMessage: "ok",
    facts: {
      storyId: "BalanceIsTooHigh_UC1",
      avg: {
        type: "PAmount",
        cols: [
          "value"
        ],
        rows: [
          [
            "12964.47"
          ]
        ],
        attributesTypes: [
          "PAmount"
        ]
      },
      confirmedParty: {
        type: "PParty",
        cols: [
          "id",
          "name",
          "hasEmail",
          "isActiveSaver",
          "smartphoneType",
          "type",
          "usedApp",
          "usedWebsite",
          "birthDate",
          "totalAssets"
        ],
        rows: [
          [
            "B_1162",
            "Moon Light",
            "true",
            "false",
            "Unknown",
            null,
            "false",
            "false",
            "1980-01-01T00:00:00.000Z",
            null
          ]
        ],
        attributesTypes: [
          "String",
          "String",
          "String",
          "String",
          "String",
          "String",
          "String",
          "String",
          "PDate",
          "PNumber"
        ]
      },
      confirmedAccount: {
        type: "PAccount",
        cols: [
          "relationType",
          "id",
          "name",
          "image",
          "availableBalance",
          "availableCredit",
          "programId",
          "accountNumber",
          "accountType",
          "balance",
          "number",
          "credit",
          "currencyCd",
          "type",
          "creditLine",
          "outstandingBalance",
          "lastStatementDueDate",
          "lastStatementMinPayment",
          "lastStatementFullBalance",
          "lastStatementCutoffDate",
          "pastDueAmount",
          "accountStatus",
          "numberOfOwners",
          "clientAccountType",
          "openDate",
          "subTypeId",
          "requestedRiskToleranceLevel",
          "actualRiskToleranceLevel",
          "maturityDate",
          "isExternal",
          "bankName"
        ],
        rows: [
          [
            "Owner",
            "B_1162_1004",
            {
              en: "1004_Checking"
            },
            null,
            "80821.54",
            "0",
            "1004_Checking",
            "1004",
            "Checking",
            "80821.54",
            "1004",
            "0",
            "$",
            "Checking",
            "0",
            "0",
            null,
            "0",
            "0",
            null,
            "0",
            "Open",
            "1",
            "Checking",
            "1980-01-01T00:00:00.000Z",
            null,
            null,
            null,
            null,
            "false",
            "B_Bank"
          ]
        ],
        attributesTypes: [
          "String",
          "String",
          "PText",
          "String",
          "PAmount",
          "PAmount",
          "String",
          "String",
          "String",
          "PAmount",
          "String",
          "PAmount",
          "String",
          "String",
          "PAmount",
          "PAmount",
          "PDate",
          "PAmount",
          "PAmount",
          "PDate",
          "PAmount",
          "String",
          "PNumber",
          "String",
          "PDate",
          "String",
          "String",
          "String",
          "PDate",
          "Boolean",
          "String"
        ]
      },
      currentDate: {
        type: "PDate",
        cols: [
          "value"
        ],
        rows: [
          [
            "2017-01-03T00:04:20.731Z"
          ]
        ],
        attributesTypes: [
          "PDate"
        ]
      },
      accounts: {
        type: "PAccount",
        cols: [
          "relationType",
          "id",
          "name",
          "image",
          "availableBalance",
          "availableCredit",
          "programId",
          "accountNumber",
          "accountType",
          "balance",
          "number",
          "credit",
          "currencyCd",
          "type",
          "creditLine",
          "outstandingBalance",
          "lastStatementDueDate",
          "lastStatementMinPayment",
          "lastStatementFullBalance",
          "lastStatementCutoffDate",
          "pastDueAmount",
          "accountStatus",
          "numberOfOwners",
          "clientAccountType",
          "openDate",
          "subTypeId",
          "requestedRiskToleranceLevel",
          "actualRiskToleranceLevel",
          "maturityDate",
          "isExternal",
          "bankName"
        ],
        rows: [
          [
            "Owner",
            "B_1162_1004",
            {
              en: "1004_Checking"
            },
            null,
            "80821.54",
            "0",
            "1004_Checking",
            "1004",
            "Checking",
            "80821.54",
            "1004",
            "0",
            "$",
            "Checking",
            "0",
            "0",
            null,
            "0",
            "0",
            null,
            "0",
            "Open",
            "1",
            "Checking",
            "1980-01-01T00:00:00.000Z",
            null,
            null,
            null,
            null,
            "false",
            "B_Bank"
          ]
        ],
        attributesTypes: [
          "String",
          "String",
          "PText",
          "String",
          "PAmount",
          "PAmount",
          "String",
          "String",
          "String",
          "PAmount",
          "String",
          "PAmount",
          "String",
          "String",
          "PAmount",
          "PAmount",
          "PDate",
          "PAmount",
          "PAmount",
          "PDate",
          "PAmount",
          "String",
          "PNumber",
          "String",
          "PDate",
          "String",
          "String",
          "String",
          "PDate",
          "Boolean",
          "String"
        ]
      },
      categories: {
        type: "PCategoryGroup",
        cols: [
          "category",
          "description"
        ],
        rows: [
          [
            "CG0",
            {
              en: "Other",
              fr: "Autre"
            }
          ],
          [
            "CG10",
            {
              en: "Personal Care"
            }
          ],
          [
            "CG100",
            {
              en: "Transportation",
              fr: "Transportation"
            }
          ],
          [
            "CG1000",
            {
              en: "Household",
              fr: "Article de maison"
            }
          ],
          [
            "CG10000",
            {
              en: "Groceries",
              fr: "Épicerie"
            }
          ],
          [
            "CG300",
            {
              en: "Utilities",
              fr: "Services publics"
            }
          ],
          [
            "CG3000",
            {
              en: "Travel",
              fr: "Voyage"
            }
          ],
          [
            "CG500",
            {
              en: "Entertainment",
              fr: "Divertissement"
            }
          ],
          [
            "CG600",
            {
              en: "Shopping",
              fr: "Magasinage"
            }
          ],
          [
            "CG6000",
            {
              en: "Education",
              fr: "Études"
            }
          ],
          [
            "CG700",
            {
              en: "Insurance",
              fr: "Finances"
            }
          ],
          [
            "CG8",
            {
              en: "Taxes & Authorities",
              fr: "Impôt"
            }
          ],
          [
            "CG800",
            {
              en: "Dining",
              fr: "Restaurant"
            }
          ],
          [
            "CG900",
            {
              en: "Health & fitness",
              fr: "Santé"
            }
          ],
          [
            "CG1100",
            {
              en: "Kids & Family"
            }
          ],
          [
            "CG1200",
            {
              en: "Savings & Investments"
            }
          ],
          [
            "CG1300",
            {
              en: "Fees & Other charges"
            }
          ],
          [
            "CG1400",
            {
              en: "Cash Withdrawal"
            }
          ],
          [
            "CG1500",
            {
              en: "Checks Posted"
            }
          ],
          [
            "CG1600",
            {
              en: "Transfers between own accounts"
            }
          ],
          [
            "CG1700",
            {
              en: "Cash Deposit"
            }
          ],
          [
            "CG1800",
            {
              en: "Check Deposit"
            }
          ],
          [
            "CG1900",
            {
              en: "Other Deposits"
            }
          ],
          [
            "CG2100",
            {
              en: "Interest & Dividends"
            }
          ],
          [
            "CG2200",
            {
              en: "Loan & Mortgage"
            }
          ],
          [
            "CG2300",
            {
              en: "Direct Deposit"
            }
          ],
          [
            "CG2400",
            {
              en: "Direct Debit & Standing Order"
            }
          ],
          [
            "CG2500",
            {
              en: "Credit Card Payments"
            }
          ],
          [
            "CG2600",
            {
              en: "Other transfers"
            }
          ],
          [
            "CG2700",
            {
              en: "Donations"
            }
          ],
          [
            "CG2800",
            {
              en: "Office expenses"
            }
          ],
          [
            "CG2900",
            {
              en: "Paycheck, Pensions & Annuity"
            }
          ],
          [
            "CG4000",
            {
              en: "Digital Wallet"
            }
          ]
        ],
        attributesTypes: [
          "String",
          "PText"
        ]
      }
    },
    story: {
      storyId: "BalanceIsTooHigh_UC1",
      dialogs: [
        {
          id: "BalanceIsTooHigh_UC1.D11",
          blocks: [
            {
              id: "text1",
              type: "txt",
              class: "perso-H2",
              txt: "title"
            },
            {
              id: "text2",
              type: "txt",
              txt: "text2",
              class: "perso-body"
            },
            {
              id: "text3",
              type: "txt",
              txt: "text3",
              class: "perso-body"
            },
            {
              id: "button1",
              type: "buttons",
              buttonType: "navigateTo",
              options: [
                {
                  id: "initiateTransfersLink",
                  type: "static",
                  txt: "text4",
                  active: true
                }
              ],
              class: "perso-button1"
            }
          ]
        }
      ],
      modals: [
        {
          blocks: [
            {
              blockId: "transaction-icon",
              type: "transactionData",
              url: "iconURL",
              section: "top"
            },
            {
              blockId: "transaction-name",
              type: "transactionData",
              text: "transactionNameTxt",
              section: "top"
            },
            {
              blockId: "transaction-links",
              type: "buttons",
              subType: "iconButton",
              options: [
                {
                  txt: "homepageLink",
                  id: "homepage",
                  type: "static"
                },
                {
                  txt: "facebookLink",
                  id: "facebook",
                  type: "static"
                },
                {
                  txt: "twitterLink",
                  id: "twitter",
                  type: "static"
                },
                {
                  txt: "customerSupportLink",
                  id: "customerSupport",
                  type: "static"
                }
              ],
              buttonType: "button",
              section: "top"
            },
            {
              blockId: "transaction-details-title",
              type: "txt",
              part: "1",
              text: "transactionDetailsTxt"
            },
            {
              blockId: "transaction-details",
              type: "entity-list",
              var: "selectedEntity",
              part: "1",
              options: [
                {
                  type: "dynamic",
                  id: "account",
                  entityTitle: "titleTxt1",
                  entityLabel1: "valueTxt1"
                },
                {
                  type: "dynamic",
                  id: "date",
                  entityTitle: "titleTxt2",
                  entityLabel1: "valueTxt2"
                },
                {
                  type: "dynamic",
                  id: "description",
                  entityTitle: "titleTxt3",
                  entityLabel1: "valueTxt3"
                },
                {
                  type: "dynamic",
                  id: "amount",
                  entityTitle: "titleTxt4",
                  entityLabel1: "valueTxt4"
                },
                {
                  type: "dynamic",
                  id: "originalAmount",
                  showIf: "selectedEntity.amountOriginalCurrency > 0 || selectedEntity.amountOriginalCurrency < 0",
                  entityTitle: "titleTxt5",
                  entityLabel1: "valueTxt5"
                },
                {
                  type: "static",
                  id: "separator"
                },
                {
                  type: "dynamic",
                  id: "category",
                  editable: true,
                  buttonLabel: "categoryCheckboxTxt",
                  entityTitle: "titleTxt6",
                  entityLabel1: "valueTxt6"
                },
                {
                  type: "dynamic",
                  id: "personalTag",
                  editable: true,
                  buttonLabel: "TagCheckboxTxt",
                  entityLabel2: "perosnalTagTxt",
                  entityTitle: "titleTxt7",
                  entityLabel1: "valueTxt7"
                }
              ]
            },
            {
              blockId: "category-update-text",
              type: "txt",
              text: "categoryUpdateTxt"
            },
            {
              blockId: "categories-list",
              type: "entity-selector",
              part: "1",
              var: "modalSelectedEntity",
              subType: "dropDown",
              default: "selectedTransaction.Category",
              options: [
                {
                  type: "data",
                  src: "categories",
                  text: "categoryLabel",
                  icon: "category"
                }
              ]
            },
            {
              blockId: "apply-all-category-checkbox",
              type: "txt",
              text: "categoryCheckboxTxt"
            },
            {
              blockId: "tag-update-text",
              blockType: "tag-update-popup",
              type: "txt",
              part: "2",
              text: "tagUpdateTxt"
            },
            {
              blockId: "tag-user-input",
              type: "txt",
              part: "2",
              text: "placeHolderTxt"
            },
            {
              blockId: "apply-all-tag-checkbox",
              type: "txt",
              text: "TagCheckboxTxt"
            },
            {
              blockId: "text-validation",
              type: "txt",
              text: "validationTxt",
              part: "2"
            },
            {
              blockId: "popup-buttons",
              type: "buttons",
              subType: "modalButton",
              options: [
                {
                  txt: "cancelTagTxt",
                  id: "cancelTagButton",
                  type: "static"
                },
                {
                  txt: "submitTagTxt",
                  id: "submitTagButton",
                  type: "static"
                }
              ],
              buttonType: "button",
              part: "2",
              section: "bottom"
            },
            {
              blockId: "error-message",
              type: "txt",
              text: "errorTxt",
              section: "bottom"
            },
            {
              blockId: "modal-buttons",
              type: "buttons",
              subType: "modalButton",
              options: [
                {
                  txt: "closeTxt",
                  id: "closeButton",
                  type: "static"
                },
                {
                  txt: "updateTxt",
                  id: "updateButton",
                  type: "static"
                }
              ],
              buttonType: "button",
              section: "bottom"
            },
            {
              blockId: "confirmation-text-updated-story",
              type: "txt",
              text: "updatedStoryTxt",
              hideBlock: true
            },
            {
              blockId: "confirmation-text-not-updated-story",
              type: "txt",
              text: "notUpdatedStoryTxt",
              hideBlock: true
            },
            {
              blockId: "closePageBlocks",
              type: "modal",
              blocks: [
                {
                  blockId: "close-page-icon",
                  type: "image",
                  url: "closeIconUrl",
                  section: "top"
                },
                {
                  blockId: "close-page-title-text",
                  type: "txt",
                  text: "closePageTitle",
                  part: "1"
                },
                {
                  blockId: "close-page-text",
                  type: "txt",
                  text: "closePageText",
                  part: "1"
                },
                {
                  blockId: "close-page-buttons",
                  type: "buttons",
                  subType: "modalButton",
                  options: [
                    {
                      txt: "stayButtonTxt",
                      id: "stayButton",
                      type: "static"
                    },
                    {
                      txt: "leaveButtonTxt",
                      id: "leaveButton",
                      type: "static"
                    }
                  ],
                  buttonType: "button",
                  section: "bottom"
                }
              ]
            }
          ],
          id: "transactionModal"
        }
      ],
      id: "BalanceIsTooHigh_UC1_Definition"
    },
    text: {
      storyId: "BalanceIsTooHigh_UC1",
      "BalanceIsTooHigh_UC1.D11": {
        en: {
          text3: "Earn more from this cash by",
          text4: "Transferring to Savings",
          text2: "After your average monthly activity of {{AvgBalance}}, you'll have significant funds leftover.",
          title: "Your current balance in account {{AccountNumber}} is {{AccountBalance}}"
        }
      },
      transactionModal: {
        en: {
          modalTitleTxt: "Transaction details",
          transactionNameTxt: "description",
          iconURL: "transactionIcon",
          categorizationTitleTxt: "Categorization",
          updateTxt: "Update",
          categoryLabel: "{{description}}",
          closeTxt: "Close",
          closeIconUrl: "attention_icon",
          closePageTitle: "Are you sure you want to leave?",
          closePageText: "Changes you made will not be saved",
          stayButtonTxt: "Stay",
          leaveButtonTxt: "Leave",
          validationTxt: "Special Characters (@#!,etc.) are not allowed",
          categoryUpdateTxt: "Category",
          tagUpdateTxt: "Personal Tag",
          TagCheckboxTxt: "Apply to similar future transactions",
          categoryCheckboxTxt: "Apply to similar future transactions",
          placeHolderTxt: "Enter your personal tag",
          updatedStoryTxt: "Transaction details were updated!",
          transactionDetailsTxt: "Transaction Details:",
          titleTxt1: "Account",
          valueTxt1: "{{transactionAccount}}",
          titleTxt2: "Date",
          valueTxt2: "{{transactionDate}}",
          titleTxt3: "Description",
          valueTxt3: "{{transactionDescription}}",
          titleTxt4: "Amount",
          valueTxt4: "{{transactionAmount}}",
          titleTxt5: "Original Amount",
          valueTxt5: "{{transactionOriginalAmount}}",
          titleTxt6: "Category",
          valueTxt6: "{{categoryGroup}}",
          titleTxt7: "Personal tag",
          valueTxt7: "{{userTag}}",
          perosnalTagTxt: "Add personal tag",
          errorTxt: "We encountered an error. Please try again later.",
          notUpdatedStoryTxt: "Thanks for the update.\nFuture insights will be updated!",
          submitTagTxt: "Submit",
          cancelTagTxt: "Cancel"
        }
      },
      TeaserDialog: {
        en: {
          date: "{{GeneratedDate}}",
          teaserText: "Your balance in account {{AccountNumber}} seems relatively high",
          alt2: "PersoSavings",
          url2: "PersoSavings",
          titleTextBox: "Savings Opportunity"
        }
      },
      title: {
        en: {
          txt: "Savings Opportunity",
          icon: ""
        }
      },
      SimpleTeaserDialog: {
        en: {
          simpleTeaserText: "Your balance in account {{AccountNumber}} seems relatively high"
        }
      }
    },
    expressions: {
      storyId: "BalanceIsTooHigh",
      AvgBalance: "Amount avg format='###,###,###' currency='AccountCurrency'",
      SourceCurrency: "currencyCd",
      SelectedAccountCurrency: "selectedAccount.currencyCd",
      AccountCurrency: "accounts.first('currencyCd')",
      AccountBalance: "Amount confirmedAccount.availableBalance format='###,###,###.00' currency='AccountCurrency'",
      GeneratedDate: "currentDate",
      AccountNumber: "confirmedAccount.accountNumber",
      transactionAccount: "accountNumber",
      transactionOriginalAmount: "Amount amountOriginalCurrency format='+###,###,###.00' currency='currencyCdOriginal'",
      transactionPersonalTag: "userTag",
      transactionAmount: "Amount amount format='+###,###,###.00' currency='currencyCd'",
      transactionCategory: "category",
      transactionDescription: "description",
      transactionDate: "Date date format='MM/DD/YYYY'"
    }
  }