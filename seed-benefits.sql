-- ============================================================
-- BenefitsFinder Australia — Initial Benefits Seed Data
-- Run this in Supabase SQL Editor AFTER schema-update.sql
-- This populates the database with 23 verified Australian benefits
-- The weekly agent will add to and update these automatically
-- ============================================================

INSERT INTO benefits (
  id, name, category, estimated_value, frequency, description,
  official_link, why_eligible_template, eligibility_rules,
  criteria, documents, steps, source_url, last_verified
) VALUES

-- ============================================================
-- GOVERNMENT BENEFITS
-- ============================================================

('ndis',
 'National Disability Insurance Scheme (NDIS)',
 'government', 57000, 'per year',
 'Funding for support and services for Australians with permanent and significant disability.',
 'https://www.ndis.gov.au/applying-access-ndis/how-apply',
 'You indicated you have a permanent disability or are unable to work due to illness.',
 '{"requires_disability": true, "probability": 85}',
 ARRAY[
   'Have a permanent and significant disability',
   'Be under 65 when first applying',
   'Be an Australian citizen, permanent resident, or Protected Special Category Visa holder',
   'Live in an NDIS area'
 ],
 ARRAY[
   'Proof of disability (medical reports)',
   'Proof of identity (passport, birth certificate)',
   'Medicare card',
   'Evidence from treating specialists'
 ],
 ARRAY[
   'Check if your area is covered at ndis.gov.au',
   'Call NDIS on 1800 800 110 to request an Access Request Form',
   'Complete the Access Request Form with supporting evidence from your doctor/specialist',
   'Submit the form online at my.ndis.gov.au or by post',
   'Wait for an Access Decision (typically 21 days)',
   'If approved, prepare for your planning meeting to discuss supports needed'
 ],
 'https://www.ndis.gov.au/applying-access-ndis/how-apply',
 NOW()
),

('age-pension',
 'Age Pension',
 'government', 29106, 'per year',
 'Regular fortnightly payments to help older Australians with living costs.',
 'https://www.servicesaustralia.gov.au/age-pension',
 'You are aged 67 or over, which is the qualifying age for the Age Pension.',
 '{"age_groups": ["67plus"], "max_income_bracket": "100-150k", "probability": 90}',
 ARRAY[
   'Have reached Age Pension age (67)',
   'Meet income and assets tests',
   'Be an Australian resident for at least 10 years'
 ],
 ARRAY[
   'Tax File Number',
   'Proof of identity',
   'Bank statements (3 months)',
   'Property/asset valuations',
   'Superannuation fund statements'
 ],
 ARRAY[
   'Create or log in to your myGov account at my.gov.au',
   'Link Centrelink to your myGov account',
   'Select "Make a claim" then "Age Pension"',
   'Complete the online claim form (takes about 30-60 minutes)',
   'Gather required documents and upload them',
   'Submit claim — decisions are typically made within 49 days'
 ],
 'https://www.servicesaustralia.gov.au/age-pension',
 NOW()
),

('dsp',
 'Disability Support Pension (DSP)',
 'government', 29106, 'per year',
 'Income support for people with a permanent physical, intellectual or psychiatric condition preventing work.',
 'https://www.servicesaustralia.gov.au/disability-support-pension',
 'You indicated you are unable to work due to a disability or medical condition.',
 '{"requires_disability": true, "employment_types": ["disabled"], "probability": 80}',
 ARRAY[
   'Have a physical, intellectual or psychiatric condition that is likely to be permanent',
   'Condition prevents working 15+ hours per week at minimum wage',
   'Be 16 or older and under Age Pension age',
   'Meet income and assets tests'
 ],
 ARRAY[
   'Medical certificate from your doctor',
   'Specialist reports',
   'Tax File Number',
   'Proof of identity',
   'Bank statements'
 ],
 ARRAY[
   'Visit your GP to get a medical certificate confirming your disability',
   'Log in to myGov and link Centrelink',
   'Select "Make a claim" → "Disability Support Pension"',
   'Fill in the online form including medical details',
   'Centrelink may arrange a Job Capacity Assessment',
   'Upload all supporting medical documentation',
   'Submit and await decision (can take up to 49 days)'
 ],
 'https://www.servicesaustralia.gov.au/disability-support-pension',
 NOW()
),

('carer-payment',
 'Carer Payment',
 'government', 29106, 'per year',
 'Income support for people who provide constant care for someone with a disability, severe illness or frail aged condition.',
 'https://www.servicesaustralia.gov.au/carer-payment',
 'You indicated you are a full-time carer for a person with disability or illness.',
 '{"requires_carer": true, "probability": 82}',
 ARRAY[
   'Provide constant daily care for a person with a severe disability, illness or frail aged condition',
   'The person you care for is assessed by Centrelink',
   'Meet income and assets tests',
   'Be an Australian resident'
 ],
 ARRAY[
   'Tax File Number',
   'Proof of identity',
   'Care receiver''s medical documentation',
   'Bank statements',
   'Care Needs Assessment form'
 ],
 ARRAY[
   'Talk to the doctor of the person you care for to get supporting medical documentation',
   'Log in to myGov and navigate to Centrelink',
   'Select "Make a claim" → "Carer Payment"',
   'Complete the online claim — you''ll need info about both yourself and the person you care for',
   'A Centrelink social worker may contact you for an assessment',
   'Submit all documents and await determination'
 ],
 'https://www.servicesaustralia.gov.au/carer-payment',
 NOW()
),

('parental-leave',
 'Parental Leave Pay',
 'government', 13108, 'lump sum / 18 weeks',
 '18 weeks of government-funded pay at the national minimum wage for eligible parents.',
 'https://www.servicesaustralia.gov.au/parental-leave-pay',
 'You indicated you have recently had a baby or are planning to, and your income qualifies.',
 '{"requires_newborn": true, "max_income_bracket": "100-150k", "probability": 88}',
 ARRAY[
   'Primary carer of a newborn or recently adopted child',
   'Individual income under $168,865 in the previous financial year',
   'Worked at least 10 of the 13 months before the birth',
   'Be an Australian resident'
 ],
 ARRAY[
   'Child''s birth registration or adoption documentation',
   'Tax File Number',
   'Bank account details',
   'Employer information'
 ],
 ARRAY[
   'Lodge claim up to 3 months before expected birth date at my.gov.au',
   'Log in to myGov → Centrelink → "Make a claim" → "Parental Leave Pay"',
   'Provide your employer''s details (they''ll receive instructions separately)',
   'Register your child''s birth with your state/territory registry',
   'Confirm the birth in your Centrelink claim',
   'Payments will flow through your employer or directly from Centrelink'
 ],
 'https://www.servicesaustralia.gov.au/parental-leave-pay',
 NOW()
),

('family-tax-a',
 'Family Tax Benefit Part A',
 'government', 5510, 'per year',
 'Regular payments to help with the cost of raising dependent children.',
 'https://www.servicesaustralia.gov.au/family-tax-benefit-part-a',
 'You have a household with children and your income is within the eligibility threshold.',
 '{"requires_children": true, "max_income_bracket": "100-150k", "probability": 87}',
 ARRAY[
   'Have a dependent child under 13 (or under 19 if in full-time study)',
   'Family income under $113,518 (higher with more children)',
   'Child meets immunisation requirements',
   'Be an Australian resident'
 ],
 ARRAY[
   'Child''s birth certificate',
   'Tax File Number',
   'Immunisation history from AIR (Medicare)',
   'Income information'
 ],
 ARRAY[
   'Log in to myGov at my.gov.au',
   'Link Services Australia/Centrelink if not already linked',
   'Click "Make a claim" → "Family assistance" → "Family Tax Benefit"',
   'Complete the form with details about your children and income',
   'Upload child''s birth certificate and immunisation records',
   'Submit — payments can begin fortnightly or as an annual lump sum at tax time'
 ],
 'https://www.servicesaustralia.gov.au/family-tax-benefit-part-a',
 NOW()
),

('family-tax-b',
 'Family Tax Benefit Part B',
 'government', 3986, 'per year',
 'Extra payment for single-income families or single parents, particularly when children are young.',
 'https://www.servicesaustralia.gov.au/family-tax-benefit-part-b',
 'Single parents or single-income families with children typically qualify.',
 '{"requires_children": true, "max_income_bracket": "60-100k", "probability": 83}',
 ARRAY[
   'Single parent, or couple where one partner earns under $100,900',
   'Have a dependent child under 13',
   'Secondary earner (if couple) earns under $100,900'
 ],
 ARRAY[
   'Child''s birth certificate',
   'Tax File Number',
   'Income details for both partners if applicable'
 ],
 ARRAY[
   'Apply at the same time as Family Tax Benefit Part A (same form)',
   'Log in to myGov → Centrelink → "Make a claim" → "Family Tax Benefit"',
   'Answer questions about your household income structure',
   'Centrelink will automatically assess eligibility for both Part A and Part B',
   'Submit and receive fortnightly payments'
 ],
 'https://www.servicesaustralia.gov.au/family-tax-benefit-part-b',
 NOW()
),

('child-care-subsidy',
 'Child Care Subsidy (CCS)',
 'government', 9000, 'per year per child',
 'Government subsidy covering up to 90% of childcare costs for eligible families.',
 'https://www.servicesaustralia.gov.au/child-care-subsidy',
 'You have a child in childcare — virtually all families receive some subsidy.',
 '{"requires_children": true, "max_income_bracket": "over150k", "probability": 90}',
 ARRAY[
   'Child is enrolled in approved childcare',
   'Both parents/partners meet the activity test (work, study or volunteer)',
   'Family income under $530,000 (receives some subsidy)',
   'Child meets immunisation requirements'
 ],
 ARRAY[
   'Child''s immunisation records (from AIR)',
   'Tax File Number',
   'Childcare provider details (centre name, CRN)'
 ],
 ARRAY[
   'Enrol your child in an approved childcare centre',
   'Log in to myGov → Centrelink → "Make a claim" → "Child Care Subsidy"',
   'Provide your childcare provider''s details',
   'The subsidy is paid directly to the childcare provider, reducing your fees',
   'Confirm your activity (work/study hours) each year at tax time'
 ],
 'https://www.servicesaustralia.gov.au/child-care-subsidy',
 NOW()
),

('jobseeker',
 'JobSeeker Payment',
 'government', 19827, 'per year',
 'Fortnightly payments for Australians who are unemployed and looking for work.',
 'https://www.servicesaustralia.gov.au/jobseeker-payment',
 'You are currently unemployed and seeking work — JobSeeker is specifically for this situation.',
 '{"employment_types": ["unemployed"], "probability": 85}',
 ARRAY[
   'Be between 22 and Age Pension age (67)',
   'Be actively looking for work',
   'Meet income and assets tests',
   'Be an Australian resident'
 ],
 ARRAY[
   'Tax File Number',
   'Proof of identity (100 points)',
   'Bank statements',
   'Employment separation certificate (if recently employed)'
 ],
 ARRAY[
   'Create a myGov account at my.gov.au if you don''t have one',
   'Link Centrelink to your myGov account',
   'Click "Make a claim" → "JobSeeker Payment"',
   'Complete the online claim (answer all questions honestly)',
   'Sign up to your Job Plan and report any income fortnightly',
   'Attend any required appointments with your job service provider'
 ],
 'https://www.servicesaustralia.gov.au/jobseeker-payment',
 NOW()
),

('youth-allowance',
 'Youth Allowance',
 'government', 14759, 'per year',
 'Fortnightly financial support for young Australians who are studying or looking for work.',
 'https://www.servicesaustralia.gov.au/youth-allowance',
 'You are aged 18-24 and are studying or looking for work — Youth Allowance is designed for you.',
 '{"age_groups": ["18-24"], "employment_types": ["student","unemployed"], "probability": 82}',
 ARRAY[
   'Be aged 16–24 (or up to 24 if studying full-time)',
   'Be studying full-time, undertaking a full-time apprenticeship, or looking for work',
   'Meet income and assets tests (including parental income if dependent)'
 ],
 ARRAY[
   'Tax File Number',
   'Proof of identity',
   'Enrolment confirmation (if studying)',
   'Bank account details'
 ],
 ARRAY[
   'Log in to myGov at my.gov.au',
   'Link Centrelink',
   '"Make a claim" → "Youth Allowance (student)" or "Youth Allowance (job seeker)"',
   'Answer questions about study load, parents'' income, and living arrangements',
   'Provide enrolment confirmation from your institution',
   'Submit and report income each fortnight'
 ],
 'https://www.servicesaustralia.gov.au/youth-allowance',
 NOW()
),

('rent-assistance',
 'Commonwealth Rent Assistance',
 'government', 5477, 'per year',
 'Extra help with rent costs for people receiving income support payments.',
 'https://www.servicesaustralia.gov.au/rent-assistance',
 'You are renting and have a low household income, making you a strong candidate for Rent Assistance.',
 '{"requires_renting": true, "max_income_bracket": "30-60k", "probability": 80}',
 ARRAY[
   'Currently receiving an eligible Centrelink payment (e.g. JobSeeker, Age Pension)',
   'Pay rent to a private landlord, community housing provider, or caravan park',
   'Pay above the minimum rent threshold'
 ],
 ARRAY[
   'Lease agreement or rent receipts',
   'Centrelink payment details'
 ],
 ARRAY[
   'If you already receive a Centrelink payment, contact them about adding Rent Assistance',
   'Log in to myGov → Centrelink → "Manage payments" → "Rent details"',
   'Provide your weekly rent amount and landlord details',
   'Rent Assistance is usually added automatically to eligible payments',
   'Report any changes in rent immediately to keep payments correct'
 ],
 'https://www.servicesaustralia.gov.au/rent-assistance',
 NOW()
),

('carer-allowance',
 'Carer Allowance',
 'government', 3990, 'per year',
 'A supplementary payment if you provide additional daily care to someone with disability or illness.',
 'https://www.servicesaustralia.gov.au/carer-allowance',
 'As a carer, you may receive both Carer Payment and the separate Carer Allowance supplement.',
 '{"requires_carer": true, "probability": 78}',
 ARRAY[
   'Provide daily care and attention for a person with a disability or medical condition',
   'Care receiver is assessed as having a disability affecting daily activities',
   'No income test for Carer Allowance'
 ],
 ARRAY[
   'Medical reports for care receiver',
   'Carer Needs Assessment form',
   'Tax File Number'
 ],
 ARRAY[
   'Apply when you claim Carer Payment, or separately through myGov',
   'Complete the "Carer Allowance" claim in Centrelink',
   'Provide medical details of the person you care for',
   'A Carer Specialist Assessment will be conducted',
   'If approved, paid fortnightly alongside other Centrelink payments'
 ],
 'https://www.servicesaustralia.gov.au/carer-allowance',
 NOW()
),

('newborn-payment',
 'Newborn Upfront Payment + Newborn Supplement',
 'government', 2014, 'lump sum',
 'One-off payment and additional supplement for families with a new baby or adopted child.',
 'https://www.servicesaustralia.gov.au/newborn-upfront-payment-and-newborn-supplement',
 'You indicated you recently had or are expecting a baby.',
 '{"requires_newborn": true, "requires_children": true, "probability": 85}',
 ARRAY[
   'Eligible for Family Tax Benefit Part A',
   'Not receiving Parental Leave Pay for the same child',
   'Child is a newborn or recently adopted'
 ],
 ARRAY[
   'Child''s birth certificate',
   'Tax File Number',
   'Centrelink family assistance details'
 ],
 ARRAY[
   'Apply for Family Tax Benefit Part A — the Newborn payments are assessed automatically',
   'Log in to myGov → Centrelink → "Add a newborn child"',
   'Complete the newborn notification',
   'Centrelink will assess eligibility and pay the lump sum to your nominated bank account'
 ],
 'https://www.servicesaustralia.gov.au/newborn-upfront-payment-and-newborn-supplement',
 NOW()
),

('fhog',
 'First Home Owner Grant (FHOG)',
 'government', 20000, 'one-off',
 'A grant of $10,000–$30,000 (varies by state) for eligible first home buyers purchasing a new home.',
 'https://www.firsthome.gov.au/',
 'You indicated you are a first home buyer — this grant is specifically for you.',
 '{"requires_first_home": true, "probability": 75}',
 ARRAY[
   'Never previously owned a property in Australia',
   'Purchasing or building a new home (not an established home)',
   'Property value under the cap for your state',
   'Must live in the property for at least 12 months',
   'Be an Australian citizen or permanent resident'
 ],
 ARRAY[
   'Contract of sale or building contract',
   'Proof of identity (passport/licence)',
   'Tax File Number',
   'Statutory declaration'
 ],
 ARRAY[
   'Confirm your state''s current grant amount and eligibility criteria (varies by state)',
   'NSW: revenue.nsw.gov.au | VIC: sro.vic.gov.au | QLD: qro.qld.gov.au',
   'Apply through your state revenue office (most have online applications)',
   'Alternatively, apply through your lender/bank if you have a mortgage',
   'Submit your application with contract of sale and identity documents',
   'Grant is typically paid at settlement or first progress payment for new builds'
 ],
 'https://www.firsthome.gov.au/',
 NOW()
),

('concession-card-savings',
 'Pensioner Concession Card / Health Care Card',
 'government', 3000, 'per year (estimated savings)',
 'Concession cards unlock hundreds of discounts on utilities, transport, council rates, car registration, and more.',
 'https://www.servicesaustralia.gov.au/concession-and-health-care-cards',
 'Based on your income and employment status, you may qualify for a Concession or Health Care Card.',
 '{"max_income_bracket": "30-60k", "employment_types": ["unemployed","disabled","retired","carer"], "probability": 80}',
 ARRAY[
   'Receive a qualifying Centrelink payment, OR',
   'Meet income criteria for a Health Care Card (low income)',
   'Be an Australian resident'
 ],
 ARRAY[
   'Tax File Number',
   'Proof of income',
   'Proof of identity'
 ],
 ARRAY[
   'If you receive Centrelink payments, a Pensioner Concession Card may be issued automatically',
   'For the Health Care Card: log in to myGov → Centrelink → "Make a claim" → "Health Care Card"',
   'Complete the form with your income details',
   'Once received, register the card with: your electricity retailer, council, toll roads, public transport, and motor registry'
 ],
 'https://www.servicesaustralia.gov.au/concession-and-health-care-cards',
 NOW()
),

-- ============================================================
-- ENERGY BENEFITS
-- ============================================================

('energy-bill-relief',
 'Energy Bill Relief Fund',
 'energy', 1500, 'per year (credits)',
 'Federal government electricity bill credits applied directly to eligible household accounts.',
 'https://www.energy.gov.au/households/energy-bill-relief',
 'Low-income households and concession card holders receive automatic energy bill credits.',
 '{"max_income_bracket": "30-60k", "requires_concession_card": false, "probability": 82}',
 ARRAY[
   'Hold a valid Pensioner Concession Card, Health Care Card or DVA card, OR',
   'Be a small business customer in eligible categories',
   'Credit applied automatically to your electricity bill — no application needed for most'
 ],
 ARRAY[
   'Concession card details',
   'Electricity account details (may be needed in some states)'
 ],
 ARRAY[
   'If you hold a Concession Card: Credits are applied automatically to your electricity bills',
   'Contact your electricity retailer to ensure your concession card is registered on your account',
   'Check your next electricity bill for the credit',
   'If you haven''t received it, call your electricity retailer with your account number and concession card number',
   'Some states have additional state-level rebates — search "[your state] energy concession rebate"'
 ],
 'https://www.energy.gov.au/households/energy-bill-relief',
 NOW()
),

('solar-stc',
 'Solar Panel STC Rebate (Small-scale Technology Certificates)',
 'energy', 5000, 'one-off',
 'Federal government rebate that reduces the upfront cost of solar panels by $3,000–$5,000.',
 'https://www.cleanenergyregulator.gov.au/RET/Scheme-participants-and-industry/Agents-and-installers/Small-scale-technology-certificates',
 'You are a homeowner interested in solar panels — the STC rebate is available to all homeowners.',
 '{"requires_solar": true, "probability": 90}',
 ARRAY[
   'Own the property where solar is being installed',
   'Use a Clean Energy Council accredited installer',
   'Install a system under 100kW',
   'System must meet Australian standards'
 ],
 ARRAY[
   'Proof of property ownership',
   'Installer''s accreditation details (they handle most paperwork)'
 ],
 ARRAY[
   'Get 3 quotes from Clean Energy Council accredited installers (the rebate is deducted from the quote)',
   'Ensure the quote shows the STC discount applied upfront',
   'The installer handles the STC paperwork — you simply receive a reduced price',
   'Check your state for additional solar rebates (VIC: Solar Homes Program, NSW: Empowering Homes)',
   'Consider adding a battery storage system which may have its own rebate'
 ],
 'https://www.cleanenergyregulator.gov.au/RET/Scheme-participants-and-industry/Agents-and-installers/Small-scale-technology-certificates',
 NOW()
),

('energy-supplement',
 'Energy Supplement',
 'energy', 366, 'per year',
 'A small supplement paid fortnightly to help with household energy costs for income support recipients.',
 'https://www.servicesaustralia.gov.au/energy-supplement',
 'Paid automatically to most Centrelink recipients — if you qualify for income support, you get this too.',
 '{"max_income_bracket": "30-60k", "employment_types": ["unemployed","disabled","retired","carer","student"], "probability": 85}',
 ARRAY[
   'Receive an eligible Centrelink payment',
   'Be an Australian resident'
 ],
 ARRAY[
   'No separate application — paid automatically with qualifying payments'
 ],
 ARRAY[
   'No action needed — this is paid automatically if you receive eligible Centrelink payments',
   'Check your Centrelink payment breakdown in myGov to confirm you''re receiving it',
   'If it''s missing, call Centrelink on 132 300 and ask about the Energy Supplement'
 ],
 'https://www.servicesaustralia.gov.au/energy-supplement',
 NOW()
),

-- ============================================================
-- HEALTHCARE BENEFITS
-- ============================================================

('low-income-tax-offset',
 'Low Income Tax Offset (LITO)',
 'government', 700, 'per tax year',
 'Automatic tax offset that reduces the amount of tax payable for low-income earners.',
 'https://www.ato.gov.au/individuals-and-families/income-deductions-offsets-and-records/tax-offsets/low-income-tax-offset',
 'Your income is within the LITO threshold — this offset is automatically applied at tax time.',
 '{"max_income_bracket": "60-100k", "probability": 95}',
 ARRAY[
   'Individual taxable income under $66,667',
   'Maximum $700 offset for incomes under $37,500',
   'Offset reduces for incomes $37,501–$66,667'
 ],
 ARRAY[
   'Payment summaries/income statements',
   'MyTax / ATO myGov access'
 ],
 ARRAY[
   'This offset is automatically calculated when you lodge your annual tax return',
   'Log in to myGov → ATO → Lodge Return (or use a tax agent)',
   'The ATO''s myTax will apply LITO automatically based on your taxable income',
   'You don''t need to claim it separately — just make sure you lodge your return!'
 ],
 'https://www.ato.gov.au/individuals-and-families/income-deductions-offsets-and-records/tax-offsets/low-income-tax-offset',
 NOW()
),

('private-health-rebate',
 'Australian Government Rebate on Private Health Insurance',
 'healthcare', 800, 'per year',
 'Government rebate on private health insurance premiums — up to 32.812% depending on age and income.',
 'https://www.ato.gov.au/individuals-and-families/medicare-and-private-health-insurance/australian-government-rebate-on-private-health-insurance',
 'If you hold private health insurance, you are likely entitled to a government rebate on your premiums.',
 '{"max_income_bracket": "over150k", "probability": 70}',
 ARRAY[
   'Hold eligible private hospital and/or general treatment cover',
   'Annual income under $186,000 (singles) or $372,000 (families)',
   'Be an Australian resident eligible for Medicare'
 ],
 ARRAY[
   'Private health insurance policy details',
   'Tax File Number',
   'Income information'
 ],
 ARRAY[
   'You can claim the rebate in one of two ways:',
   'Option A: Reduced premiums — contact your health fund and register for the rebate directly',
   'Option B: Tax return — claim it as a tax offset when lodging your return via myGov → ATO',
   'Option A is simpler. Call your health fund and say you want to apply the government rebate'
 ],
 'https://www.ato.gov.au/individuals-and-families/medicare-and-private-health-insurance/australian-government-rebate-on-private-health-insurance',
 NOW()
),

('medicare-safety-net',
 'Medicare Safety Net',
 'healthcare', 700, 'per year (once threshold met)',
 'Once you''ve spent enough on out-of-pocket medical costs, Medicare reimburses a higher percentage.',
 'https://www.servicesaustralia.gov.au/medicare-safety-net',
 'All Australians with a Medicare card are enrolled in the Medicare Safety Net automatically.',
 '{"probability": 60}',
 ARRAY[
   'All Medicare cardholders are automatically enrolled',
   'Must reach the annual threshold ($531.70 for concession holders, $2,249.80 for others)',
   'Tracking resets each calendar year'
 ],
 ARRAY[
   'Medicare card'
 ],
 ARRAY[
   'No application needed — you are automatically enrolled',
   'Check your balance via myGov → Medicare → "Safety Net balance"',
   'Keep all medical receipts — you can add gaps to your tally',
   'Once threshold is met, Medicare automatically pays a higher benefit for future services',
   'Register your family together on the same safety net (call Medicare on 132 011)'
 ],
 'https://www.servicesaustralia.gov.au/medicare-safety-net',
 NOW()
),

('pbs-concession',
 'PBS Concession Card Prescription Benefits',
 'healthcare', 690, 'per year (estimated 30 scripts)',
 'Concession card holders pay only $7.30 per PBS prescription instead of the standard $30.70.',
 'https://www.servicesaustralia.gov.au/concession-and-health-care-cards',
 'With a Concession Card or low income, you pay a dramatically reduced rate for medications.',
 '{"max_income_bracket": "30-60k", "requires_concession_card": true, "probability": 75}',
 ARRAY[
   'Hold a Pensioner Concession Card, Health Care Card, or Commonwealth Seniors Health Card',
   'Prescription must be for a PBS-listed medicine'
 ],
 ARRAY[
   'Concession card (present at pharmacy)'
 ],
 ARRAY[
   'Check if you are eligible for a Concession Card or Health Care Card via myGov → Centrelink',
   'Apply for a Health Care Card if you don''t have one (low-income Australians may qualify)',
   'Once you have the card, present it at the pharmacy each time you fill a prescription',
   'You''ll pay $7.30 per script instead of up to $30.70',
   'Keep a PBS Safety Net concession record card from your pharmacist'
 ],
 'https://www.servicesaustralia.gov.au/concession-and-health-care-cards',
 NOW()
),

('veterans-supplement',
 'Veterans'' Entitlements & Supplements',
 'government', 6000, 'per year',
 'A range of payments and concessions for veterans, war widows, and defence family members.',
 'https://www.dva.gov.au/financial-support/pension-and-allowances',
 'You indicated you are a veteran or defence family member — DVA has a range of dedicated entitlements.',
 '{"requires_veteran": true, "probability": 80}',
 ARRAY[
   'Have served in the Australian Defence Force or be a family member of a veteran',
   'Various eligibility criteria apply to different payments',
   'Contact DVA for a personal entitlements assessment'
 ],
 ARRAY[
   'Service record / discharge papers',
   'Proof of identity',
   'Medical records (if claiming for health condition)'
 ],
 ARRAY[
   'Visit the DVA website at dva.gov.au or call 1800 VETERAN (1800 838 372)',
   'Request a free entitlements review from a DVA counsellor',
   'Key payments include: Service Pension, Disability Pension, Veterans'' Supplement, Gold/White/Orange card',
   'Apply through myGov → link Veterans'' Affairs',
   'A free advocate from the RSL or Vietnam Veterans Association can help with complex claims'
 ],
 'https://www.dva.gov.au/financial-support/pension-and-allowances',
 NOW()
)

ON CONFLICT (id) DO UPDATE SET
  name                  = EXCLUDED.name,
  estimated_value       = EXCLUDED.estimated_value,
  frequency             = EXCLUDED.frequency,
  description           = EXCLUDED.description,
  official_link         = EXCLUDED.official_link,
  why_eligible_template = EXCLUDED.why_eligible_template,
  eligibility_rules     = EXCLUDED.eligibility_rules,
  criteria              = EXCLUDED.criteria,
  documents             = EXCLUDED.documents,
  steps                 = EXCLUDED.steps,
  source_url            = EXCLUDED.source_url,
  last_verified         = NOW(),
  updated_at            = NOW();

-- ============================================================
-- Confirm what was inserted
-- ============================================================
SELECT id, name, estimated_value, category FROM benefits ORDER BY estimated_value DESC;
