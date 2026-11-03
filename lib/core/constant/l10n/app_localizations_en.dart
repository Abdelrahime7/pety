// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'PetPaw+';

  @override
  String get tagline => 'Caring for your best friends';

  @override
  String get save => 'Save';

  @override
  String get saveChanges => 'Save changes';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get keep => 'Keep';

  @override
  String get discard => 'Discard';

  @override
  String get all => 'All';

  @override
  String get seeAll => 'See all';

  @override
  String get view => 'View';

  @override
  String get viewRecords => 'View records';

  @override
  String get tryAgain => 'Try again';

  @override
  String get loading => 'Loading...';

  @override
  String get saving => 'Saving…';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get other => 'Other';

  @override
  String get pet => 'Pet';

  @override
  String get notSpecified => 'Not specified';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get pressBackAgainToExit => 'Press back again to exit';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLbs => 'lbs';

  @override
  String get navHome => 'Home';

  @override
  String get navPets => 'Pets';

  @override
  String get navHealth => 'Health';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get navProfile => 'Profile';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get signIn => 'Sign In';

  @override
  String get signUp => 'Sign Up';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get fullName => 'Full name';

  @override
  String get hintFullName => 'John Doe';

  @override
  String get emailAddress => 'Email address';

  @override
  String get hintEmail => 'name@example.com';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get noAccountPrompt => 'Don’t have an account? ';

  @override
  String get haveAccountPrompt => 'Already have an account? ';

  @override
  String get pleaseEnterName => 'Please enter your name';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get accountAndSecurity => 'Account & Security';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get privacyAndSecurity => 'Privacy & Security';

  @override
  String get appPreferences => 'App Preferences';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get language => 'Language';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get languageSystem => 'System default';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageArabic => 'العربية';

  @override
  String get cloudBackup => 'Cloud Backup';

  @override
  String get logOut => 'Log Out';

  @override
  String get changePassword => 'Change Password';

  @override
  String get errorLoadingProfile => 'Error loading profile';

  @override
  String get changePhoto => 'Change photo';

  @override
  String get uploadPhoto => 'Upload photo';

  @override
  String get userName => 'User name';

  @override
  String get emailCannotBeChanged => 'Email cannot be changed manually. ';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String get profileUpdateCancelled => 'Profile update cancelled';

  @override
  String get subscription => 'Subscription';

  @override
  String get memberSince => 'Member since';

  @override
  String get upgrade => 'Upgrade';

  @override
  String get premiumPlan => 'Premium Plan';

  @override
  String get freePlan => 'Free Plan';

  @override
  String get premium => 'Premium';

  @override
  String get petCareMember => 'Pet Care Member';

  @override
  String get anonymousUser => 'Anonymous User';

  @override
  String get upgradeToPremium => 'Upgrade to Premium';

  @override
  String get premiumSubtitle =>
      'Give your pets the best care with\nadvanced tracking and insights.';

  @override
  String get annualPlan => 'Annual Plan';

  @override
  String get billedYearly => 'Billed yearly';

  @override
  String get monthlyPlan => 'Monthly Plan';

  @override
  String get flexibleBilling => 'Flexible billing';

  @override
  String get bestValue => 'Best value';

  @override
  String savePercent(int percent) {
    return 'Save $percent%';
  }

  @override
  String get startFreeTrial => 'Start 7-Day Free Trial';

  @override
  String get premiumTerms =>
      'By continuing, you agree to our Terms of Service and\nPrivacy Policy. Cancel anytime.';

  @override
  String get featureUnlimitedPets => 'Unlimited Pets';

  @override
  String get featureUnlimitedPetsDesc =>
      'Track as many pets as you have in one account.';

  @override
  String get featureCloudBackup => 'Cloud Backup & Sync';

  @override
  String get featureCloudBackupDesc =>
      'Never lose your pet’s medical records or data.';

  @override
  String get featureFamilySharing => 'Family Sharing';

  @override
  String get featureFamilySharingDesc =>
      'Add partners or caregivers to manage pets together.';

  @override
  String get featurePdfReports => 'PDF Health Reports';

  @override
  String get featurePdfReportsDesc =>
      'Export records to share with vets or insurance.';

  @override
  String premiumBrandTitle(String appName) {
    return '$appName Premium';
  }

  @override
  String get getUnlimitedCare => 'Get Unlimited Care';

  @override
  String get unlockPremium =>
      'Unlock multi-pet support, cloud backup,\nand health export features.';

  @override
  String upgradeNowPrice(String price) {
    return 'Upgrade Now — $price/mo';
  }

  @override
  String get notifications => 'Notifications';

  @override
  String get chooseNotifications =>
      'Choose which notifications you want to receive about your pets.';

  @override
  String get appointmentReminders => 'Appointment reminders';

  @override
  String get appointmentRemindersDesc =>
      'Get notified about your pet’s upcoming appointments.';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String get noNotifications => 'No notifications';

  @override
  String get allCaughtUp => 'You are all caught up! ';

  @override
  String get allCaughtUpDesc =>
      'We will notify you when something needs your attention.';

  @override
  String get justNow => 'Just now';

  @override
  String get yesterday => 'Yesterday';

  @override
  String minutesAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes ago',
      one: '$count minute ago',
    );
    return '$_temp0';
  }

  @override
  String hoursAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours ago',
      one: '$count hour ago',
    );
    return '$_temp0';
  }

  @override
  String daysAgo(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days ago',
      one: '$count day ago',
    );
    return '$_temp0';
  }

  @override
  String get goodMorning => 'Good morning 👋';

  @override
  String get helloPetParent => 'Hello, Pet Parent!';

  @override
  String get makePetHappy => 'Let’s make your pet happy today.';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get everythingYourPetNeeds => 'Everything your pet needs';

  @override
  String get upcomingAppointment => 'Upcoming Appointment';

  @override
  String get healthOverview => 'Health Overview';

  @override
  String get unableToLoadPets => 'Unable to load your pets.';

  @override
  String get myCompanions => 'My Companions';

  @override
  String companionsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count beloved companions',
      one: '$count beloved companion',
    );
    return '$_temp0';
  }

  @override
  String get everyGreatStory => 'Every great story starts here';

  @override
  String get addFirstCompanionDesc =>
      'Add your first companion and give them the care they deserve.';

  @override
  String get addFirstPet => 'Add your first pet';

  @override
  String get appointments => 'Appointments';

  @override
  String get scheduleVisits => 'Schedule visits';

  @override
  String get healthRecords => 'Health Records';

  @override
  String get trackHealth => 'Track health';

  @override
  String get vaccinations => 'Vaccinations';

  @override
  String get vaccines => 'Vaccines';

  @override
  String get myPets => 'My Pets';

  @override
  String get petProfiles => 'Pet profiles';

  @override
  String get keepTrackVaccineDoses => 'Keep track of vaccine doses';

  @override
  String get medicalHistory => 'Medical History';

  @override
  String get checkPetHealthRecords => 'Check your pet’s health records';

  @override
  String get addNewPet => 'Add New Pet';

  @override
  String get addPet => 'Add Pet';

  @override
  String get editPet => 'Edit Pet';

  @override
  String get petDetails => 'Pet Details';

  @override
  String get deletePet => 'Delete Pet';

  @override
  String get deleting => 'Deleting...';

  @override
  String get basicInformation => 'Basic Information';

  @override
  String get petName => 'Pet name';

  @override
  String get species => 'Species';

  @override
  String get breed => 'Breed';

  @override
  String get gender => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get dog => 'Dog';

  @override
  String get cat => 'Cat';

  @override
  String get bird => 'Bird';

  @override
  String get birthDate => 'Birth date';

  @override
  String get weight => 'Weight';

  @override
  String get weightLbs => 'Weight (lbs)';

  @override
  String get neuteredSpayed => 'Neutered / Spayed';

  @override
  String get medicalNotes => 'Medical notes';

  @override
  String get hintPetName => 'e.g. Luna';

  @override
  String get hintBreed => 'e.g. Golden Retriever';

  @override
  String get hintWeight => '0.0';

  @override
  String get hintAllergies => 'Allergies, chronic conditions, etc.';

  @override
  String get hintPetNotes => 'Add notes about your pet...';

  @override
  String get hintEnterPetName => 'Enter pet name';

  @override
  String get hintEnterBreed => 'Enter breed';

  @override
  String get hintEnterWeight => 'Enter weight';

  @override
  String get hintDateMDY => 'mm/dd/yyyy';

  @override
  String get savingYourPet => 'Saving your pet…';

  @override
  String get yourPets => 'Your Pets';

  @override
  String get manageFurryFriends =>
      'Manage all your furry friends in one place.';

  @override
  String get noPetsAdded => 'You haven’t added any pets yet.';

  @override
  String get noMatchingPets => 'No matching pets found.';

  @override
  String get petNameRequired => 'Pet name is required';

  @override
  String get breedRequired => 'Breed is required';

  @override
  String get weightRequired => 'Weight is required';

  @override
  String get invalidWeight => 'Enter a valid weight';

  @override
  String get birthDateRequired => 'Birth date is required';

  @override
  String get petUpdated => 'Pet updated successfully';

  @override
  String get notes => 'Notes';

  @override
  String get notScheduled => 'Not scheduled';

  @override
  String activeSeries(int count) {
    return 'Active series: $count';
  }

  @override
  String ageYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '$count year',
    );
    return '$_temp0';
  }

  @override
  String ageMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '$count month',
    );
    return '$_temp0';
  }

  @override
  String ageYearsOld(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years old',
      one: '$count year old',
    );
    return '$_temp0';
  }

  @override
  String ageMonthsOld(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months old',
      one: '$count month old',
    );
    return '$_temp0';
  }

  @override
  String get lessThanMonth => 'Less than a month';

  @override
  String get lessThanYear => 'Less than a year';

  @override
  String get puppyKitten => 'Puppy / Kitten';

  @override
  String petsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pets',
      one: '$count pet',
    );
    return '$_temp0';
  }

  @override
  String get health => 'Health';

  @override
  String get allHealthRecords => 'All Health Records';

  @override
  String get selectPetToViewRecords => 'Select a pet to view their records.';

  @override
  String get searchByNameOrBreed => 'Search by name or breed...';

  @override
  String get failedToLoadPets => 'Failed to load pets.';

  @override
  String get unableToLoadHealthRecords => 'Unable to load health records.';

  @override
  String get couldNotLoadRecords => 'We could not load the health records.';

  @override
  String get healthRecordAdded => 'Health record added successfully';

  @override
  String get addHealthRecord => 'Add Health Record';

  @override
  String get recordInformation => 'Record Information';

  @override
  String get recordType => 'Record type';

  @override
  String get selectRecordTypeSubtitle => 'Select the type of health record';

  @override
  String get whatKindOfRecord => 'What kind of health record are you adding?';

  @override
  String get title => 'Title';

  @override
  String get hintRecordTitle => 'e.g. Annual checkup';

  @override
  String get pleaseEnterTitle => 'Please enter a title';

  @override
  String get date => 'Date';

  @override
  String get whenDidThisHappen => 'When did this happen?';

  @override
  String get veterinarian => 'Veterinarian';

  @override
  String get hintVetName => 'e.g. Dr. Sarah Smith';

  @override
  String get hintAdditionalInfo => 'Add any additional information...';

  @override
  String get keepRecordsUpToDate =>
      'Keep your pet’s health records up to date to make it easier to track their health history.';

  @override
  String get noHealthRecordsYet => 'No health records yet';

  @override
  String get healthRecordsWillAppear =>
      'Health records for all your pets will appear here.';

  @override
  String healthRecordsForPetWillAppear(String petName) {
    return 'Health records for $petName will appear here.';
  }

  @override
  String noFilteredRecords(String type) {
    return 'No $type records';
  }

  @override
  String noFilteredRecordsForPet(String type, String petName) {
    return 'There are no $type records for $petName.';
  }

  @override
  String get showingRecordsFor => 'Showing records for';

  @override
  String get addingRecordFor => 'Adding record for';

  @override
  String recordsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count records',
      one: '$count record',
    );
    return '$_temp0';
  }

  @override
  String get yourPetsHealth => 'Your pets’ health';

  @override
  String recordsAcrossPets(String records, String pets) {
    return '$records across $pets';
  }

  @override
  String get vaccination => 'Vaccination';

  @override
  String get checkup => 'Checkup';

  @override
  String get medication => 'Medication';

  @override
  String get allergy => 'Allergy';

  @override
  String get surgery => 'Surgery';

  @override
  String get treatment => 'Treatment';

  @override
  String get grooming => 'Grooming';

  @override
  String get allVaccinations => 'All Vaccinations';

  @override
  String get unableToLoadVaccinations => 'Unable to load vaccinations.';

  @override
  String get failedToLoadVaccinations => 'Failed to load vaccinations';

  @override
  String get noVaccinationsYet => 'No vaccinations yet';

  @override
  String get keepPetHealthyAddVaccinations =>
      'Keep your pet healthy by adding their vaccinations.';

  @override
  String get vaccinationRecordsWillAppear =>
      'Vaccination records for all your pets will appear here.';

  @override
  String get addVaccination => 'Add Vaccination';

  @override
  String get savingVaccination => 'Saving vaccination…';

  @override
  String get vaccinationAdded => 'Vaccination added successfully';

  @override
  String get vaccinationDetails => 'Vaccination Details';

  @override
  String get vaccinationHistory => 'Vaccination history';

  @override
  String get vaccinationSeries => 'Vaccination series';

  @override
  String get createNewSeries => 'Create new series';

  @override
  String get useExistingSeries => 'Use existing series';

  @override
  String get vaccinationDate => 'Vaccination date';

  @override
  String get vaccinationDateRequired => 'Vaccination date is required';

  @override
  String get hintVaccinationNotes => 'Optional notes about this vaccination...';

  @override
  String get vaccine => 'Vaccine';

  @override
  String get vaccineName => 'Vaccine name';

  @override
  String get hintVaccineName => 'e.g. Rabies';

  @override
  String get vaccineNameRequired => 'Vaccine name is required';

  @override
  String get numberOfDoses => 'Number of doses';

  @override
  String get hintDoses => 'e.g. 3';

  @override
  String get enterValidDoses => 'Enter a valid number of doses';

  @override
  String get doseProgress => 'Dose progress';

  @override
  String get requiredDoses => 'Required doses';

  @override
  String get dose => 'Dose';

  @override
  String doseNumber(int number) {
    return 'Dose $number';
  }

  @override
  String nextDose(int number) {
    return 'Next dose: $number';
  }

  @override
  String dosesCompleted(int completed, int total) {
    return '$completed/$total doses completed';
  }

  @override
  String dosesOfRequired(int completed, int total) {
    return '$completed / $total doses';
  }

  @override
  String dosesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count doses',
      one: '$count dose',
    );
    return '$_temp0';
  }

  @override
  String get status => 'Status';

  @override
  String get created => 'Created';

  @override
  String get description => 'Description';

  @override
  String get completed => 'Completed';

  @override
  String get inProgress => 'In progress';

  @override
  String get selectSeries => 'Select series';

  @override
  String get selectASeries => 'Select a series';

  @override
  String get selectVaccinationSeries => 'Select Vaccination Series';

  @override
  String get noActiveSeries => 'No active vaccination series found. ';

  @override
  String get createNewSeriesInstead => 'Create a new series instead.';

  @override
  String get loadingSeries => 'Loading series...';

  @override
  String get noSeriesFound => 'No series found.';

  @override
  String get searchVaccine => 'Search vaccine...';

  @override
  String get unknownPet => 'Unknown pet';

  @override
  String get appointment => 'Appointment';

  @override
  String get newAppointment => 'New Appointment';

  @override
  String get editAppointment => 'Edit Appointment';

  @override
  String get scheduleAppointment => 'Schedule Appointment';

  @override
  String get schedulingAppointment => 'Scheduling appointment…';

  @override
  String get cancelAppointmentTitle => 'Cancel appointment?';

  @override
  String get cancelAppointmentMessage =>
      'Are you sure you want to cancel this appointment? This action cannot be undone.';

  @override
  String get cancelVisit => 'Cancel visit';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get past => 'Past';

  @override
  String get noAppointmentsYet => 'No appointments yet.';

  @override
  String get noAppointmentsOnDay => 'No appointments on this day.';

  @override
  String get pleaseSelectPet => 'Please select a pet';

  @override
  String get pleaseSelectDateTime => 'Please select date and time';

  @override
  String get selectPet => 'Select pet';

  @override
  String get type => 'Type';

  @override
  String get dateAndTime => 'Date & time';

  @override
  String get hintDateTime => 'mm / dd / yyyy , --:-- --';

  @override
  String get hintAnythingVetShouldKnow => 'Anything the vet should know...';

  @override
  String get dateRequired => 'Date is required';

  @override
  String get vetNameRequired => 'Veterinarian name is required';

  @override
  String get editing => 'Editing';

  @override
  String get petDetailsUnavailable => 'Pet details unavailable';

  @override
  String completedOn(String date) {
    return 'Completed $date';
  }

  @override
  String appointmentWithPet(String petName) {
    return 'Appointment — $petName';
  }

  @override
  String doctorWithPet(String doctor, String petName) {
    return '$doctor — $petName';
  }

  @override
  String get noNotesAdded => 'No notes added.';
}
