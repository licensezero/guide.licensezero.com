# Developers' Guide

This guide lays out the nuts and bolts of [License Zero] and its approach to sustaining your work in software development.  The guide aims to explain how License Zero works, and the choices you can make while using it.

[License Zero]: https://licensezero.com

## <a id="how">How License Zero Works</a>

License Zero is made of five pieces:

1. Public licenses give everyone permission to use software under certain conditions.

2. A web service sells specific buyers permission to use software under different conditions.

3. A command-line interface reads and writes metadata about License Zero software.

4. Legal terms define the relationship between developers and Artless Devices LLC, the company behind License Zero.

5. Form agreements and quotes help developers make other deals about their software.

## Overview

Before diving into the choices you'll make as a developer using License Zero, let's take a look at the system from the user point of view:

### Noncommercial Use of a L0-NC Project

I am a hobbyist building a website about electronic music.  I find a content management system online.  It's licensed under the [License Zero Noncommercial Public License][L0-NC].  That license's conditions limit commercial use to 30 days.  Since I'm not building my website for any commercial purpose, I can use the software for my project as long as I like.

[L0-NC]: https://licensezero.com/licenses/noncommercial

### Commercial Use of an L0-NC Project

I am a record label building a website to promote new releases.  I find the same content management system online. Since I want to use the software to promote my business and make money for more than 30 days, I can't meet the conditions of the public license.  But I can purchase a [private license] through License Zero.  When I do so, License Zero sends me a cryptographically signed private license that allows my company to use the software for commercial purposes, and pays the developer.

[private license]: https://licensezero.com/licenses/private

### Free Use of a L0-R Project

I'm building an open source library to convert between two map data formats. I find a library that parses the first format online.  It's licensed under the [License Zero Reciprocal Public License][L0-R].  That license's conditions require releasing software built with the code as open source.  As long as I release my conversion library as open source, I'm free to use the parser library in it.

### Sponsored Relicensing of a L0-R Project

I'm building a mobile app that teaches users to play famous guitar solos.  I find a library that renders guitar tablature online.  It's licensed under the [License Zero Reciprocal Public License][L0-R].  My company _could_ make its app as open source, but prefers to keep it proprietary.  Since not just my company, but all the users our app will need to use the library as part of the app, the company sponsors relicensing the project onto the [License Zero Permissive Public License][L0-P].  License Zero pays the developer, and the developer relicenses their project under the terms of a standard [relicensing agreement].

[L0-R]: https://licensezero.com/licenses/reciprocal

[relicensing agreement]: https://licensezero.com/licenses/relicense

## <a id="choices">Choices to Make</a>

### Public License

I want to use software I've found online. If the software has a public license---written permission, under intellectual property laws, that applies to _everyone_---and I can follow its conditions, then I can go ahead and use the software. If I can't follow the public license's conditions, I need to contact the owner of intellectual property rights in the software, probably the developers or their employers, and get a private license, specific to me, with conditions that I _can_ follow.

```javascript

if (project.publicLicense) {
  var canFollow = project
    .publicLicense
    .conditions
    .every(function (condition) {
      return i.canFollow(condition)
    })
  if (canFollow) {
    i.canUse(project)
  } else {
    i.needAPrivateLicenseFor(project)
  }
}
```

License Zero offers your choice of two public licenses:

The _reciprocal_ license requires users to share back source code they build using your software.

### Private License Pricing

### Relicensing Offer

### Handling Contributions
