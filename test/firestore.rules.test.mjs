
import { readFileSync } from 'node:fs';
import { before, after, test } from 'node:test';

import {
  initializeTestEnvironment,
  assertSucceeds,
  assertFails,
} from '@firebase/rules-unit-testing';

import {
  collection,
  updateDoc,
  doc,
  getDoc,
  getDocs,
  getCountFromServer,
  query,
  setDoc,
  where,
} from 'firebase/firestore';

const PROJECT_ID = 'demo-pety-rules-test';

let testEnv;

// --------------------------------------------------
// SETUP
// --------------------------------------------------

before(async () => {
  testEnv = await initializeTestEnvironment({
    projectId: PROJECT_ID,
    firestore: {
      rules: readFileSync('firestore.rules', 'utf8'),
    },
  });

  // Seed test data without applying security rules.
  await testEnv.withSecurityRulesDisabled(async (context) => {
    const db = context.firestore();

    // Users
    await setDoc(doc(db, 'users/userA'), {
      name: 'User A',
    });

    await setDoc(doc(db, 'users/userB'), {
      name: 'User B',
    });

    // Pets
    await setDoc(doc(db, 'pets/petA'), {
      ownerId: 'userA',
      name: 'Pet A',
    });

    await setDoc(doc(db, 'pets/petB'), {
      ownerId: 'userB',
      name: 'Pet B',
    });

    // Appointments
    await setDoc(doc(db, 'appointments/appointmentA'), {
      userId: 'userA',
      petId: 'petA',
      type: 'checkup',
    });

    await setDoc(doc(db, 'appointments/appointmentB'), {
      userId: 'userB',
      petId: 'petB',
      type: 'checkup',
    });

    // Health records
    await setDoc(doc(db, 'healthRecords/healthA'), {
      ownerId: 'userA',
      petId: 'petA',
      title: 'Health A',
    });

    await setDoc(doc(db, 'healthRecords/healthB'), {
      ownerId: 'userB',
      petId: 'petB',
      title: 'Health B',
    });

    // Vaccination records
    await setDoc(doc(db, 'vaccinationRecords/vaccineA'), {
      ownerId: 'userA',
      petId: 'petA',
    });

    await setDoc(doc(db, 'vaccinationRecords/vaccineB'), {
      ownerId: 'userB',
      petId: 'petB',
    });

    // Vaccination series
    await setDoc(doc(db, 'vaccinationSeries/serieA'), {
      ownerId: 'userA',
      petId: 'petA',
      vaccineName: 'Rabies',
      requiredDoses: 3,
      completedDoses: 1,
      isCompleted: false,
    });

    await setDoc(doc(db, 'vaccinationSeries/serieB'), {
      ownerId: 'userB',
      petId: 'petB',
      vaccineName: 'Rabies',
      requiredDoses: 3,
      completedDoses: 1,
      isCompleted: false,
    });

    // Notifications
    await setDoc(doc(db, 'notifications/notificationA'), {
      userId: 'userA',
      title: 'Notification A',
      isRead: false,
    });

    await setDoc(doc(db, 'notifications/notificationB'), {
      userId: 'userB',
      title: 'Notification B',
      isRead: false,
    });
  });
});

// --------------------------------------------------
// CLEANUP
// --------------------------------------------------

after(async () => {
  await testEnv?.cleanup();
});

// --------------------------------------------------
// USERS
// --------------------------------------------------

test('User can read their own user document', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getDoc(doc(db, 'users/userA')),
  );
});

test('User cannot read another user document', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertFails(
    getDoc(doc(db, 'users/userB')),
  );
});

// --------------------------------------------------
// PETS
// --------------------------------------------------

test('User can query their own pets', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getDocs(
      query(
        collection(db, 'pets'),
        where('ownerId', '==', 'userA'),
      ),
    ),
  );
});

test('User cannot read another users pet', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertFails(
    getDoc(doc(db, 'pets/petB')),
  );
});

// --------------------------------------------------
// APPOINTMENTS
// --------------------------------------------------

test('Appointment query by userId and petId whereIn', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getDocs(
      query(
        collection(db, 'appointments'),
        where('userId', '==', 'userA'),
        where('petId', 'in', ['petA']),
      ),
    ),
  );
});

test('Appointment query by petId equality', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getDocs(
      query(
        collection(db, 'appointments'),
        where('petId', '==', 'petA'),
      ),
    ),
  );
});

test('User cannot directly read another users appointment', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertFails(
    getDoc(doc(db, 'appointments/appointmentB')),
  );
});

test('Owner can update their appointment', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    updateDoc(doc(db, 'appointments/appointmentA'), {
      veterinarian: 'Updated Veterinarian',
    }),
  );
});

test('Owner cannot change appointment petId to another users pet', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertFails(
    updateDoc(doc(db, 'appointments/appointmentA'), {
      petId: 'petB',
    }),
  );
});

test('Owner cannot change appointment userId', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertFails(
    updateDoc(doc(db, 'appointments/appointmentA'), {
      userId: 'userB',
    }),
  );
});

test('Another user cannot update appointment', async () => {
  const db = testEnv.authenticatedContext('userB').firestore();

  await assertFails(
    updateDoc(doc(db, 'appointments/appointmentA'), {
      veterinarian: 'Unauthorized Update',
    }),
  );
});

// --------------------------------------------------
// HEALTH RECORDS
// --------------------------------------------------

test('Health records query by petId', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getDocs(
      query(
        collection(db, 'healthRecords'),
        where('petId', '==', 'petA'),
      ),
    ),
  );
});

test('Health records query by ownerId', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getDocs(
      query(
        collection(db, 'healthRecords'),
        where('ownerId', '==', 'userA'),
      ),
    ),
  );
});

test('User cannot directly read another users health record', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertFails(
    getDoc(doc(db, 'healthRecords/healthB')),
  );
});

// --------------------------------------------------
// VACCINATION RECORDS
// --------------------------------------------------

test('Vaccination query by petId', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getDocs(
      query(
        collection(db, 'vaccinationRecords'),
        where('petId', '==', 'petA'),
      ),
    ),
  );
});

test('Vaccination query by ownerId', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getDocs(
      query(
        collection(db, 'vaccinationRecords'),
        where('ownerId', '==', 'userA'),
      ),
    ),
  );
});

test('User cannot directly read another users vaccination', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertFails(
    getDoc(doc(db, 'vaccinationRecords/vaccineB')),
  );
});

// --------------------------------------------------
// NOTIFICATIONS
// --------------------------------------------------

test('User can query their own notifications', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getDocs(
      query(
        collection(db, 'notifications'),
        where('userId', '==', 'userA'),
      ),
    ),
  );
});

test('User cannot read another users notification', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertFails(
    getDoc(doc(db, 'notifications/notificationB')),
  );
});

// --------------------------------------------------
// VACCINATION SERIES
// --------------------------------------------------

test('Vaccination series query by ownerId and petId', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getDocs(
      query(
        collection(db, 'vaccinationSeries'),
        where('ownerId', '==', 'userA'),
        where('petId', '==', 'petA'),
      ),
    ),
  );
});

test('User cannot directly read another users vaccination series', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertFails(
    getDoc(doc(db, 'vaccinationSeries/serieB')),
  );
});

test('Vaccination series active count by ownerId and petId', async () => {
  const db = testEnv.authenticatedContext('userA').firestore();

  await assertSucceeds(
    getCountFromServer(
      query(
        collection(db, 'vaccinationSeries'),
        where('ownerId', '==', 'userA'),
        where('petId', '==', 'petA'),
        where('isCompleted', '==', false),
      ),
    ),
  );
});
