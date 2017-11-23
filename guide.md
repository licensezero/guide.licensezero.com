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

I'm building a mobile app that teaches users to play famous guitar solos.  I find a library that renders guitar tablature online.  It's licensed under the [License Zero Reciprocal Public License][L0-R].  My company wants to keep its app proprietary.  Since not just my company, but all the users our app will need to use the library as part of the app, the company sponsors relicensing the project onto the [License Zero Permissive Public License][L0-P].  License Zero pays the developer, and the developer relicenses the project under the terms of a standard [relicensing agreement].  Now everyone, including my company, is free to use the library to build and use proprietary software.

[L0-R]: https://licensezero.com/licenses/reciprocal

[L0-P]: https://licensezero.com/licenses/permissive

[relicensing agreement]: https://licensezero.com/licenses/relicense

### Takeaways

1.  License Zero gives you, the developer, a choice of two public licenses: one limits commercial use to 30 days, the other requires users to release code they build with your work as open source.

2.  Users who can follow the conditions of the public license you choose can use your software freely.

3.  You can use License Zero to sell private licenses to users who can't meet the conditions of your public license.

4.  You can also use License Zero to offer to relicense your project onto permissive terms for a one-time fee.

## <a id="choices">Choices to Make</a>

### Public License

You can use License Zero for projects that use either of two public licenses:

The [reciprocal license][L0-R] requires users to release source code for software they build with your work as open source.  Users who can't or don't want to release their own work as open source need to buy a private license.

The [noncommercial license][L0-NC] limits commercial users of your project to a trial period.  Commercial users who need more than the trial period need to buy a private license.

### Private License Pricing

### Relicensing Offer

### Handling Contributions
